FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    token { Faker::Internet.unique.password }
    google_id { Faker::Internet.unique.password }
    location { Faker::Address.unique.full_address }
  end
end