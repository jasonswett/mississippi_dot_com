require 'rails_helper'

RSpec.feature 'Create order', type: :feature do
  describe 'valid inputs' do
    before do
      @book_1 = create(:book)
      @book_2 = create(:book)
      @order_form = OrderForm.new
      visit new_order_path
    end

    scenario 'when books are selected' do
      @order_form.fill(customer_email: 'test@example.com')
        .select_books(@book_1.name, @book_2.name)
        .submit

      expect(page).to have_content(@book_1.name)
      expect(page).to have_content(@book_1.name)
    end
  end

  scenario 'customer email is missing' do
    visit new_order_path
    click_on 'Create Order'
    expect(page).to have_content("Customer can't be blank")
  end

  scenario 'customer email is missing and order ultimately gets created' do
    book = create(:book)

    visit new_order_path
    fill_in 'Customer email', with: ''
    check book.name
    click_on 'Create Order'

    expect(page).to have_content("Customer can't be blank")
    fill_in 'Customer email', with: 'test@example.com'
    click_on 'Create Order'

    visit orders_path
    expect(page).to have_content(book.name)
  end

  scenario 'customer exists and is not signed in yet' do
    user = create(:user, email: 'test@example.com')
    book = create(:book)

    visit new_order_path
    check book.name
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
