module Events
  class CreateInBunch
    def initialize(events, schedule_id, user_id)
      @events = events
      @user_id = user_id
      @schedule_id = schedule_id
    end

    def call
      temp = Event.where(schedule_id: schedule_id, user_id: user_id, kind: 0).pluck(:id)
      create
      Event.where(id: temp).destroy_all
    end

    private

    attr_reader :events, :schedule_id, :user_id

    def create
      Event.transaction do
        Event.create!(events)
      end
    end
  end
end
