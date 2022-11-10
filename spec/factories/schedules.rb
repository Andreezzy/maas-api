FactoryBot.define do
  factory :schedule do
    company { create(:company) }
    start_date { Date.new(2022,11,10).beginning_of_week(:sunday) }
    end_date { Date.new(2022,11,10).end_of_week }
    min_time { Time.new(0,1,1,8) }
    max_time { Time.new(0,1,1,18) }

    factory :schedule_with_business_hours do
      after(:create) do |schedule|
        7.times do |day|
          create(:business_hour, day_of_week: day, schedule: schedule)
        end
      end
    end
  end
end
