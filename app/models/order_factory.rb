class OrderFactory
  def self.build(customer_email:, book_ids: [])
    Order.new(
      customer: Customer.find_or_create_by(email: customer_email),
      line_items: line_items(book_ids.reject(&:blank?))
    )
  end

  def self.line_items(book_ids)
    Book.find(book_ids).map do |book|
      LineItem.new(
        book: book,
        total_amount_cents: book.price_cents
      )
    end
  end
end
