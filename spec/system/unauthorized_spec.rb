
require 'rails_helper'

RSpec.describe 'restrict', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user,:admin) }
  let(:not_verified_user) { FactoryBot.create(:user,:not_verified) }

  scenario 'guest visiting home' do
    visit root_path
    expect(page).to have_content 'Sign in'
  end

  scenario 'not verified user visiting home' do
    sign_in_with not_verified_user
    visit root_path
    expect(page).to have_content 'Verify'
  end
  
  scenario 'user visiting admin dashboard' do
    sign_in_with user
    visit admin_users_path
    expect(page).to have_content 'Stocks'
  end

  scenario 'admin visiting home' do
    sign_in_with admin
    visit root_path
    expect(page).to have_content 'Users'
  end


end