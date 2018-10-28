class OrderFactory
  def self.build(customer_email:, book_ids: [])
    customer = Customer.find_or_create_by(email: customer_email)
    order = customer.orders.new
    add_line_items(order, book_ids)
    order
  end

  def self.add_line_items(order, book_ids)
    books(book_ids).each do |book|
      order.line_items.new(
        book: book,
        total_amount_cents: 0
      )
    end
  end

  def self.books(book_ids)
    Book.find(book_ids.reject(&:blank?))
  end
end
