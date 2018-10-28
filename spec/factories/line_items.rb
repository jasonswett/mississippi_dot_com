FactoryBot.define do
  factory :line_item do
    order
    book
    quantity { 1 }
    total_amount_cents { 1 }
  end
end
