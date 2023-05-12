
require 'rails_helper'

RSpec.describe 'admin dashboard', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:pending_user) { FactoryBot.create(:user,:pending) }
  let(:admin) { FactoryBot.create(:user,:admin) }
  let(:new_user) { FactoryBot.build(:user,:new) }

  scenario 'view user' do
    sign_in_with admin
    visit admin_user_path(pending_user)
    expect(page).to have_content pending_user.email.upcase
  end

  scenario 'approve user' do
    sign_in_with admin
    visit edit_admin_user_path(pending_user)
    select("approved", from: "status")
    click_on('Submit')
  end

  scenario 'create user' do
    sign_in_with admin
    visit new_admin_user_path
    fill_in 'user[email]', with: new_user.email
    fill_in 'user[password]', with: new_user.password
    fill_in 'user[password_confirmation]', with: new_user.password_confirmation
    click_on('Submit')
  end

end