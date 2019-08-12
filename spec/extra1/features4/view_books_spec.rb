require 'rails_helper'

RSpec.feature 'View books', type: :feature do
  scenario 'viewing' do
    create(:book)
    visit admin_books_path
  end
end
