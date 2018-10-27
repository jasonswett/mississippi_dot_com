FactoryBot.define do
  factory :book do
    name { "MyString" }
    price_cents { 1 }
    date_published { "2018-10-27" }
  end
end
