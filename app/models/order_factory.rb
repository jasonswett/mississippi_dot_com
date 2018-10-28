class OrderFactory
  def self.build(customer_email:, book_ids: [])
    customer = Customer.find_or_create_by(email: customer_email)
    order = customer.orders.new

    Book.find(book_ids).each do |book|
      order.line_items.new(
        book: book,
        total_amount_cents: 0
      )
    end

    order
  end
end
