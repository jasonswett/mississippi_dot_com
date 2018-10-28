require 'rails_helper'

RSpec.describe OrderFactory, type: :model do
  describe 'creation' do
    it 'saves the order' do
      order = OrderFactory.build(customer_email: 'test@example.com')
      order.save!

      expect(order).to be_persisted
    end
  end
end
