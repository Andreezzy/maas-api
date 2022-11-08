FactoryBot.define do
  factory :user do
    name { 'Ash' }
    last_name { 'Perez' }
    email { 'ash@gmail.com' }
    color { '#FF8787' }
    avatar { 'https://github.com/Andreezzy/profile-pictures/blob/main/avatar-1.png' }
    password { 'password'}
    password_confirmation { 'password' }
  end
end
