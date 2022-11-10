require 'rails_helper'

RSpec.describe "/api/v1/events", type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode({ user_id: user.id }) }
  let(:schedule) { create(:schedule_with_business_hours) }

  let(:valid_attributes) {{
    schedule_id: schedule.id,
    user_id: user.id,
    kind: 0,
    start_time: DateTime.new(2022,11,10, 12),
    end_time: DateTime.new(2022,11,10, 13)
  }}

  let(:invalid_attributes) {{
    start_time: nil
  }}

  let(:valid_headers) {{
    'Authorization': "Bearer #{token}"
  }}

  describe "GET /index" do
    it "renders a successful response" do
      Event.create! valid_attributes
      get api_v1_events_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      event = Event.create! valid_attributes
      get api_v1_event_url(event), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Event" do
        expect {
          post api_v1_events_url,
               params: { events: [valid_attributes], schedule_id: schedule.id }, headers: valid_headers, as: :json
        }.to change(Event, :count)
      end

      it "renders a JSON response with the new event" do
        post api_v1_events_url,
             params: { events: valid_attributes, schedule_id: schedule.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect {
          post api_v1_events_url,
               params: { events: [invalid_attributes], schedule_id: schedule.id }, as: :json
        }.to change(Event, :count).by(0)
      end

      it "renders a JSON response with errors for the new event" do
        post api_v1_events_url,
             params: { events: [invalid_attributes], schedule_id: schedule.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{
        start_time: DateTime.new(2022,11,10, 13),
        end_time: DateTime.new(2022,11,10, 14)
      }}

      # it "updates the requested event" do
      #   event = Event.create! valid_attributes
      #   patch api_v1_event_url(event),
      #         params: { event: new_attributes }, headers: valid_headers, as: :json
      #   event.reload
      #   skip("Add assertions for updated state")
      # end

      it "renders a JSON response with the event" do
        event = Event.create! valid_attributes
        patch api_v1_event_url(event),
              params: { event: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the event" do
        event = Event.create! valid_attributes
        patch api_v1_event_url(event),
              params: { event: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete api_v1_event_url(event), headers: valid_headers, as: :json
      }.to change(Event, :count).by(-1)
    end
  end
end
