module Api
  module V1
    class EventsController < Api::V1::ApiController
      before_action :set_event, only: %i[ show update destroy ]
      before_action :set_event_handler, only: %i[ index create ]

      # GET events
      def index
        render json: Panko::Response.new(
          all_drafts: Panko::ArraySerializer.new(@event_handler.all_drafts, each_serializer: EventSerializer),
          my_drafts: Panko::ArraySerializer.new(@event_handler.my_drafts, each_serializer: EventSerializer),
          all_published: Panko::ArraySerializer.new(@event_handler.all_published, each_serializer: EventSerializer)
        )
      end

      # GET events/1
      def show
        render json: @event
      end

      # POST events
      def create
        Events::CreateInBunch.new(events_params, params[:schedule_id], @current_user.id).call
        Events::SortPublishedEvents.new(params[:schedule_id]).call
        render json: Panko::Response.new(
          all_drafts: Panko::ArraySerializer.new(@event_handler.all_drafts, each_serializer: EventSerializer),
          my_drafts: Panko::ArraySerializer.new(@event_handler.my_drafts, each_serializer: EventSerializer),
          all_published: Panko::ArraySerializer.new(@event_handler.all_published, each_serializer: EventSerializer)
        )
      rescue ActiveRecord::RecordInvalid => e
        render json: e, status: :unprocessable_entity
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

      def set_event_handler
        @event_handler = Events::EventHandler.new(params[:schedule_id], @current_user.id)
      end

      def events_params
        params.permit(events: %i[schedule_id user_id kind start_time end_time]).require(:events)
      end

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
