class Customer < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
