FactoryBot.define do
  factory :business_hour do
    schedule { nil }
    day_of_week { 1 }
    start_time { DateTime.now }
    end_time { DateTime.now + 1.hour }
  end
end
