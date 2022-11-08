FactoryBot.define do
  factory :event do
    schedule { nil }
    user { nil }
    kind { 1 }
    start_time { "2022-11-08 15:42:51" }
    end_time { "2022-11-08 15:42:51" }
  end
end
