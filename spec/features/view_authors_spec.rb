require 'rails_helper'

RSpec.feature 'View authors', type: :feature do
  scenario 'viewing' do
    create(:author)
    visit admin_authors_path
    sleep(5)
  end
end
