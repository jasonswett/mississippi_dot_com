require 'rails_helper'

RSpec.feature 'Update book', type: :feature do
  scenario 'invalid attributes' do
    book = create(:book)
    visit edit_admin_book_path(book)
    fill_in 'Name', with: ''
    click_on 'Update Book'
  end
end
