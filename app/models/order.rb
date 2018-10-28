class Order < ApplicationRecord
  belongs_to :customer
  validates :customer, presence: true
  validates :customer_id, presence: true
end
