class Book < ApplicationRecord
  monetize :price_cents
  validates :name, presence: true, uniqueness: true
end
