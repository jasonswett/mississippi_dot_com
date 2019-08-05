require 'rails_helper'

RSpec.feature 'Create book', type: :feature do
  context 'valid attributes' do
    scenario 'multiple authors' do
      create(:author, name: 'Steve Freeman')
      create(:author, name: 'Nat Pryce')

      visit new_admin_book_path
      fill_in 'Name', with: 'Growing Object-Oriented Software, Guided by Tests'
      fill_in 'Price', with: '45.82'
      select 'Steve Freeman', from: 'Author(s)'
      select 'Nat Pryce', from: 'Author(s)'
      click_on 'Create Book'

      expect(page).to have_content('Book was successfully created.')
      expect(page).to have_content('Steve Freeman')
      expect(page).to have_content('Nat Pryce')
    end
  end

  scenario 'invalid attributes' do
    sleep(5)
    visit new_admin_book_path
    click_on 'Create Book'
    expect(page).to have_content("Name can't be blank")
  end
end
