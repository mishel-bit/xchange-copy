
require 'rails_helper'

RSpec.describe 'admin dashboard', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user,:admin) }

  scenario 'view user' do
    sign_in_with admin
    visit admin_user_path(user)
    expect(page).to have_content user.email.upcase
  end

  scenario 'edit user' do
    sign_in_with admin
    visit edit_admin_user_path(user)
    expect(page).to have_content 'Edit'
  end

end