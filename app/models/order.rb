class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  has_many :books, through: :line_items
  validates :customer, presence: true
  validates :customer_id, presence: true
  monetize :total_cents

  def summary
    line_items.map(&:book).map(&:name).join(', ')
  end

  def total_cents
    line_items.sum(:total_amount_cents)
  end
end
