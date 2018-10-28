class Customer < ApplicationRecord
  has_many :orders
  validates :email, presence: true, uniqueness: true

  def to_s
    email
  end
end
