require 'rails_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  describe 'POST /sessions' do
    context 'without params' do
      it 'returns http status unauthorized' do
        post '/api/v1/sessions'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with params' do
      context 'with valid credentials' do
        let(:user) { create(:user) }
        let(:body) { JSON.parse(response.body) }

        before { post '/api/v1/sessions', params: { email: user.email, password: user.password } }

        it 'returns http status success' do
          expect(response).to have_http_status(:success)
        end
        it 'returns a payload with the needed fields' do
          expect(body['user'].keys).to include(*%w[id name last_name email color avatar])
        end
        it 'returns a payload with the user token' do
          expect(body['token']).not_to be_empty
        end
      end

      context 'with invalid credentials' do
        it 'returns http status unauthorized' do
          post '/api/v1/sessions', params: { email: 'fake@gmail.com', password: '12341234' }
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
