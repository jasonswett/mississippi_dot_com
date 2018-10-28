class OrderFactory
  def self.build(customer_email:)
    customer = Customer.find_or_create_by(email: customer_email)
    customer.orders.new
  end
end
