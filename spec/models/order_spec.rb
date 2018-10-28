require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe 'validations' do
    it { should validate_presence_of(:customer) }
  end
end
