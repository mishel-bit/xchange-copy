

require 'rails_helper'

RSpec.describe 'user', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user,password_reset_token: "123456") }
  
  scenario 'forgot password with valid email' do
    visit sign_in_path
    click_on('Forgot Password?')
    fill_in 'user[email]', with: user.email
    click_on('Send Password Reset Email')
    expect(page).to have_content 'A password reset link has been sent to your email'
  end

  scenario 'forgot password with invalid email' do
    visit sign_in_path
    click_on('Forgot Password?')
    fill_in 'user[email]', with: "invalid@email.com"
    click_on('Send Password Reset Email')
    expect(page).to have_content 'Invalid email'
  end

  scenario 'reset password' do
    visit reset_password_path(user.password_reset_token)
    expect(page).to have_content 'Reset Password'
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation
    click_on('Submit new password')
    expect(page).to have_content 'Password reset successful'
  end
end