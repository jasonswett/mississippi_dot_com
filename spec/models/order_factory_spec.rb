require 'rails_helper'

RSpec.describe OrderFactory, type: :model do
  describe 'creation' do
    it 'saves the order' do
      order = OrderFactory.build(customer_email: 'test@example.com')
      order.save!

      expect(order).to be_persisted
    end

    context 'build' do
      it 'creates line items' do
        book = create(:book)

        order = OrderFactory.build(
          customer_email: 'test@example.com',
          book_ids: [book.id]
        )

        expect(order.line_items.first.book.id).to eq(book.id)
      end
    end

    context 'create' do
      it 'saves line items' do
        book = create(:book)

        order = OrderFactory.build(
          customer_email: 'test@example.com',
          book_ids: [book.id]
        )
        order.save!

        expect(order.line_items.first.book.id).to eq(book.id)
      end
    end
  end
end
