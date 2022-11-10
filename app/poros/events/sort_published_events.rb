module Events
  class SortPublishedEvents
    def initialize(schedule_id)
      @schedule = Schedule.find(schedule_id)
    end

    def call
      clear_published_events
      assign_events_with_no_collisions
      assign_events_with_collisions
    end

    private

    attr_reader :schedule

    def clear_published_events
      schedule.events.where(kind: 1).destroy_all
    end

    def assign_events_with_no_collisions
      days_of_week.each do |day|
        day_of_week = day.strftime('%w')
        current_date = day.to_datetime
        day_schedule = business_hours[day_of_week]

        hours = (day_schedule.start_time.strftime('%H')..day_schedule.end_time.strftime('%H')).to_a

        if draft_events_per_day.has_key?(day_of_week)
          user_hours = draft_events_per_day[day_of_week].each_with_object({}) {|k, h| (h[k.user_id] ||= []).push((k.start_time.strftime('%H')...k.end_time.strftime('%H')).to_a)}

          # Events without users
          all_user_hours = user_hours.values.flatten.sort.uniq
          i = 0
          start_hour = nil
          hours.each do |h|
            if h == all_user_hours[i]
              i += 1
              if start_hour
                create_warning_event(current_date.change({hour: start_hour.to_i}), current_date.change({hour: h.to_i}))
                start_hour = nil
              end
            else
              start_hour ||= h
            end
          end
          if i != all_user_hours.length - 1
            create_warning_event(current_date.change({hour: start_hour.to_i}), current_date.change({hour: hours[-1].to_i}))
          end

          # Events with no collisions
          uniq = user_hours.values.flatten.sort.tally.select{|k, v| v == 1}.keys
          user_hours.each do |user_id, hours_range|
            hours_range.each do |hours|
              start_hour = nil
              hours.each do |hour|
                if uniq.exclude?(hour)
                  if start_hour
                    create_user_event(user_id, current_date.change({hour: start_hour.to_i}), current_date.change({hour: hour.to_i}))
                    total_user_hours[user_id] += hour.to_i - start_hour.to_i
                    start_hour = nil
                  end
                else
                  start_hour ||= hour
                end
              end
              if start_hour
                create_user_event(user_id, current_date.change({hour: start_hour.to_i}), current_date.change({hour: hours[-1].to_i + 1}))
                total_user_hours[user_id] += (hours[-1].to_i + 1) - start_hour.to_i
              end
            end
          end
        else
          Event.create!(schedule_id: schedule.id, user_id: nil, kind: 1, start_time: current_date.change({hour: hours[0].to_i}), end_time: current_date.change({hour: hours[-1].to_i}))
          next
        end
      end
    end

    def assign_events_with_collisions
      days_of_week.each do |day|
        day_of_week = day.strftime('%w')
        current_date = day.to_datetime
        day_schedule = business_hours[day_of_week]

        hours = (day_schedule.start_time.strftime('%H')..day_schedule.end_time.strftime('%H')).to_a

        if draft_events_per_day.has_key?(day_of_week)
          user_hours = draft_events_per_day[day_of_week].each_with_object({}) {|k, h| (h[k.user_id] ||= []).push((k.start_time.strftime('%H')...k.end_time.strftime('%H')).to_a)}

          # Events with collisions
          collisions = user_hours.values.flatten.tally.select{|k, v| v != 1}.keys

          while !collisions.empty? do
            user_id = total_user_hours.filter{|x| user_hours.keys.include?(x)}.min_by{|x,v| v}[0]
            user_hours[user_id].each do |hours|
              start_hour = nil
              hours.each do |hour|
                if collisions.exclude?(hour)
                  if start_hour
                    create_user_event(user_id, current_date.change({hour: start_hour.to_i}), current_date.change({hour: hour.to_i}))
                    total_user_hours[user_id] += hour.to_i - start_hour.to_i
                    start_hour = nil
                  end
                else
                  start_hour ||= hour
                  collisions.delete(hour)
                end
              end
              if start_hour
                create_user_event(user_id, current_date.change({hour: start_hour.to_i}), current_date.change({hour: hours[-1].to_i + 1}))
                total_user_hours[user_id] += (hours[-1].to_i + 1) - start_hour.to_i
              end
            end
          end
        end
      end
    end

    def total_user_hours
      @total_user_hours ||= User.joins(:events)
                                .where('events.kind = 0 and events.schedule_id = ?', schedule.id)
                                .distinct.pluck(:id)
                                .to_h {|id| [id, 0]}
    end

    def create_warning_event(start_time, end_time)
      Event.create!(schedule_id: schedule.id, user_id: nil, kind: 1, start_time: start_time, end_time: end_time)
    end

    def create_user_event(user_id, start_time, end_time)
      Event.create!(schedule_id: schedule.id, user_id: user_id, kind: 1, start_time: start_time, end_time: end_time)
    end

    def draft_events_per_day
      @draft_events_per_day ||= Event.joins(:schedule)
                                     .where('events.kind = 0')
                                     .where('schedules.id = ?', schedule.id)
                                     .order(:start_time)
                                     .group_by {|x| x[:start_time].strftime('%w')}
    end

    def days_of_week
      @days_of_week ||= (schedule.start_date...schedule.end_date).to_a
    end

    def business_hours
      @business_hours ||= schedule.business_hours.order(:day_of_week)
                                  .inject({}) { |temp, h| temp.merge(Hash[h.day_of_week.to_s, h]) }
    end
  end
end
