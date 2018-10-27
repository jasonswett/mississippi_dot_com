class Book < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
