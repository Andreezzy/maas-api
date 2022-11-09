module Api
  module V1
    class EventsController < Api::V1::ApiController
      before_action :set_event, only: %i[ show update destroy ]

      # GET events
      def index
        load_events = Events::LoadEvents.new(params[:schedule_id], @current_user.id)

        render json: Panko::Response.new(
          all_drafts: Panko::ArraySerializer.new(load_events.all_drafts, each_serializer: EventSerializer),
          my_drafts: Panko::ArraySerializer.new(load_events.my_drafts, each_serializer: EventSerializer),
          all_published: Panko::ArraySerializer.new(load_events.all_published, each_serializer: EventSerializer)
        )
      end

      # GET events/1
      def show
        render json: @event
      end

      # POST events
      def create
        @event = Event.new(event_params)

        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE events/1
      def destroy
        @event.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:schedule_id, :user_id, :kind, :start_time, :end_time)
      end
    end
  end
end
