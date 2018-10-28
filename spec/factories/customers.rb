FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
  end
end
