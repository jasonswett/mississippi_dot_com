require 'rails_helper'

RSpec.feature 'Sign in', type: :feature do
  scenario 'valid inputs' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'invalid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: 'bad@example.com'
    fill_in 'Password', with: 'invalid'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
