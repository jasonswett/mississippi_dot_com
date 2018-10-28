require 'rails_helper'

RSpec.feature 'Create order', type: :feature do
  scenario 'customer email is missing' do
    visit new_order_path
    click_on 'Create Order'
    expect(page).to have_content("Customer can't be blank")
  end

  scenario 'customer exists' do
    create(:customer, email: 'test@example.com')
    visit customers_path
    expect(page).to have_content('test@example.com', count: 1)

    visit orders_path
    expect(page).not_to have_content('test@example.com')
    visit new_order_path
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    visit orders_path
    expect(page).to have_content('test@example.com')

    visit customers_path
    expect(page).to have_content('test@example.com', count: 1)
  end

  scenario 'customer does not exist' do
    visit customers_path
    expect(page).not_to have_content('test@example.com')

    visit orders_path
    expect(page).not_to have_content('test@example.com')
    visit new_order_path
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    visit orders_path
    expect(page).to have_content('test@example.com')

    visit customers_path
    expect(page).to have_content('test@example.com', count: 1)
  end
end
