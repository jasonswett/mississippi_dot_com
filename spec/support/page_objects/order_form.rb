class OrderForm
	include Capybara::DSL 

  def fill(options)
    fill_in 'Customer email', with: options[:customer_email]
    self
  end

  def select_books(*book_names)
    book_names.each do |book_name|
      check book_name
    end

    self
  end

  def submit
    click_on 'Create Order'
  end
end
