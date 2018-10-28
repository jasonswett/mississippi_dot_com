require 'rails_helper'

RSpec.describe LineItem, type: :model do
  subject { build(:line_item) }

  describe 'validations' do
    it { should validate_presence_of(:order) }
    it { should validate_presence_of(:book) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_uniqueness_of(:book_id).scoped_to(:order_id) }
  end
end
