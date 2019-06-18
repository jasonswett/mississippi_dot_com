require 'rails_helper'

RSpec.feature 'Create order', type: :feature do
  # TODO: break this file into multiple files

  scenario 'when books are selected' do
    create(:book, name: 'Growing Object-Oriented Software, Guided by Tests')
    create(:book, name: 'Test-Driven Development by Example')

    visit new_order_path
    fill_in 'Customer email', with: 'test@example.com'
    check 'Growing Object-Oriented Software, Guided by Tests'
    check 'Test-Driven Development by Example'
    click_on 'Create Order'

    visit orders_path
    expect(page).to have_content('Growing Object-Oriented Software, Guided by Tests')
    expect(page).to have_content('Test-Driven Development by Example')
  end

  scenario 'customer email is missing' do
    visit new_order_path
    click_on 'Create Order'
    expect(page).to have_content("Customer can't be blank")
  end

  scenario 'customer email is missing and order ultimately gets created' do
    create(:book, name: 'Growing Object-Oriented Software, Guided by Tests')
    create(:book, name: 'Test-Driven Development by Example')

    visit new_order_path
    fill_in 'Customer email', with: ''
    check 'Growing Object-Oriented Software, Guided by Tests'
    check 'Test-Driven Development by Example'
    click_on 'Create Order'

    expect(page).to have_content("Customer can't be blank")
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    visit orders_path
    expect(page).to have_content('Growing Object-Oriented Software, Guided by Tests')
    expect(page).to have_content('Test-Driven Development by Example')
  end

  scenario 'customer exists and is not signed in yet' do
    user = create(:user, email: 'test@example.com')
    create(:book, name: 'Enlightenment Now')

    visit new_order_path
    check 'Enlightenment Now'
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    fill_in 'Password', with: user.password
    click_on 'Create Order'

    expect(page).to have_content('Sign out')
  end

  scenario 'customer is signed in' do
    user = create(:user)
    book = create(:book)
    login_as(user)

    visit new_order_path
    check book.name
    click_on 'Create Order'

    expect(page).to have_content(user.email)
    expect(page).to have_content(book.name)
  end

  scenario 'customer does not exist' do
    visit customers_path
    expect(page).not_to have_content('test@example.com')

    visit orders_path
    expect(page).not_to have_content('test@example.com')
    visit new_order_path
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    expect(page).to have_content('test@example.com')

    visit customers_path
    expect(page).to have_content('test@example.com', count: 1)
  end
end
