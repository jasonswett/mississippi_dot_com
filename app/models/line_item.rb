class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  validates :order, presence: true
  validates :book, presence: true
  validates :quantity, presence: true, numericality: true
  validates :book_id, uniqueness: { scope: :order_id }
end
