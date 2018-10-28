class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items
  validates :customer, presence: true
  validates :customer_id, presence: true

  def summary
    line_items.map(&:book).map(&:name).join(', ')
  end
end
