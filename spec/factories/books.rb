FactoryBot.define do
  factory :book do
    name { Faker::Lorem.characters(10) }
    price_cents { 1 }
    date_published { "2018-10-27" }
  end
end
