module Events
  class LoadEvents
    def initialize(schedule_id, user_id)
      @schedule_id = schedule_id
      @user_id = user_id
    end

    def my_drafts
      events.where(user_id: user_id, kind: 0)
    end

    def all_drafts
      events.where(kind: 0)
    end

    def all_published
      events.where(kind: 1)
    end

    private

    attr_reader :schedule_id, :user_id

    def events
      @events ||= Event.where(schedule_id: schedule_id)
    end
  end
end
