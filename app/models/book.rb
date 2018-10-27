class Book < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships
  monetize :price_cents
  validates :name, presence: true, uniqueness: true

  def author_names
    authors.map(&:name).join(', ')
  end
end
