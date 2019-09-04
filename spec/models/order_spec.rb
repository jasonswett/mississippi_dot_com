require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe 'validations' do
    it { should validate_presence_of(:customer) }
  end

  describe '#total_cents' do
    it 'returns the total amount for the order' do
      order = create(
        :order,
        line_items: [
          create(:line_item, total_amount_cents: 5000),
          create(:line_item, total_amount_cents: 2500)
        ]
      )

      expect(order.total_cents).to eq(7500)
    end
  end
end
