require 'rails_helper'

RSpec.describe OrderFactory, type: :model do
  describe 'creation' do
    it 'saves the order' do
      order = OrderFactory.build(customer_email: 'test@example.com')
      order.save!

      expect(order).to be_persisted
    end

    context 'with blank book ids' do
      let(:book) { create(:book) }

      let(:order) do
        OrderFactory.build(
          customer_email: 'test@example.com',
          book_ids: ['', book.id]
        )
      end

      it 'still saves the order' do
        expect { order.save! }.not_to raise_error
      end
    end

    context 'with line items' do
      let(:book) { create(:book) }

      let(:order) do
        OrderFactory.build(
          customer_email: 'test@example.com',
          book_ids: [book.id]
        )
      end

      context 'order is not persisted' do
        it 'creates line items' do
          expect(order).not_to be_persisted
          expect(order.line_items.first.book.id).to eq(book.id)
        end
      end

      context 'order is persisted' do
        before { order.save! }

        it 'saves line items' do
          expect(order).to be_persisted
          expect(order.line_items.first.book.id).to eq(book.id)
        end
      end
    end
  end
end
