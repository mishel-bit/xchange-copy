
require 'rails_helper'

RSpec.describe 'sign in', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { FactoryBot.create(:user,:admin) }
  let(:approved_trader) { FactoryBot.create(:user) }
  let(:pending_trader) { FactoryBot.create(:user,:pending) }
  let(:not_verified_user) { FactoryBot.create(:user,:not_verified) }
  let(:blank_email) { FactoryBot.build(:user,email: nil) }
  let(:blank_password) { FactoryBot.build(:user,password: nil) }
  let(:invalid_user) { FactoryBot.build(:user,email:"incorrect", password: "incorrect") }

  scenario 'invalid user without email' do
    sign_in_with blank_email
    expect(page).to have_content "Email can't be blank"
  end

  scenario 'invalid user without password' do
    sign_in_with blank_password
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'invalid email or password' do
    sign_in_with invalid_user
    expect(page).to have_content "Email / Password is invalid"
  end

  scenario 'unverified user' do
    sign_in_with not_verified_user
    expect(page).to have_content 'Verify'
  end

  scenario 'pending trader' do
    sign_in_with pending_trader
    expect(page).to have_content 'Account'
  end

  scenario 'approved trader' do
    sign_in_with approved_trader
    visit root_path
    expect(page).to have_content 'Stocks'
  end

  scenario 'admin' do
    sign_in_with admin
    expect(page).to have_content 'Users'
  end

  scenario 'logged in already' do
    sign_in_with approved_trader
    visit sign_in_path
    expect(page).to have_content 'Stocks'
  end

end