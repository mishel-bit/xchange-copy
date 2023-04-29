
require 'rails_helper'

RSpec.describe 'verify', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:new_user) { FactoryBot.create(:user,:new, verification_code: "1234") }
  
  scenario 'verify email' do
    sign_in_with new_user
    expect(page).to have_content 'Verify'
    fill_in 'Verification code', with: new_user.verification_code
    click_on('Submit')
    expect(page).to have_content 'Your Account'
  end

  scenario 'resend code' do
    sign_in_with new_user
    click_on('Resend Code')
    expect(page).to have_content 'Verification code sent to your email'
  end

end