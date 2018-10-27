class Authorship < ApplicationRecord
  belongs_to :author
  belongs_to :book
  validates :book, presence: true
  validates :author, presence: true
  validates :book_id, uniqueness: { scope: :author_id }
end
