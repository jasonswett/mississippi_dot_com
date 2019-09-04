require 'rails_helper'

RSpec.feature 'View authors', type: :feature do
  scenario 'viewing' do
    create(:author)
    visit admin_authors_path
  end
end
