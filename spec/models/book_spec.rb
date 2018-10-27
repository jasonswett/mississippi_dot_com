require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { build(:book) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
