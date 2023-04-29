

require 'rails_helper'

RSpec.describe 'user', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  
  scenario 'forgot password with valid email' do
    visit sign_in_path
    click_on('Forgot Password?')
    fill_in 'Email', with: user.email
    click_on('Send Password Reset Email')
    expect(page).to have_content 'A password reset link has been sent to your email'
  end

  scenario 'forgot password with invalid email' do
    visit sign_in_path
    click_on('Forgot Password?')
    fill_in 'Email', with: "invalid@email.com"
    click_on('Send Password Reset Email')
    expect(page).to have_content 'Invalid email'
  end

end