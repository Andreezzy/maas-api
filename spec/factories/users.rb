FactoryBot.define do
  factory :user do
    name { 'Ash' }
    last_name { 'Perez' }
    email { 'ash@gmail.com' }
    password { 'password'}
    password_confirmation { 'password' }
  end
end
