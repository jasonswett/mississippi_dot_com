require 'rails_helper'

RSpec.feature 'Create book', type: :feature do
  scenario 'Creating a book' do
    visit new_book_path
    fill_in 'Name', with: 'Growing Object-Oriented Software, Guided by Tests'
    fill_in 'Price', with: '45.82'
    click_on 'Create Book'
    expect(page).to have_content('Book was successfully created.')
  end
end
