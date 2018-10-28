class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items
  validates :customer, presence: true
  validates :customer_id, presence: true
end
