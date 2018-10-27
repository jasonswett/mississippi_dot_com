require 'rails_helper'

RSpec.describe Authorship, type: :model do
  subject { build(:authorship) }

  describe 'validations' do
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:book) }
    it { should validate_uniqueness_of(:book_id).scoped_to(:author_id) }
  end
end
