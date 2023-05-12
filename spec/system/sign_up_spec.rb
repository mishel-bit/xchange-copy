
require 'rails_helper'
RSpec.describe 'sign up', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:new_user) { FactoryBot.build(:user,:new) }
  let(:registered_user) { FactoryBot.create(:user) }

  scenario 'existing user email' do
    sign_up_with registered_user.email, registered_user.password, registered_user.password_confirmation
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'invalid user without email' do
    sign_up_with "", new_user.password, new_user.password_confirmation
    expect(page).to have_content "Email can't be blank"
  end

  scenario 'invalid user with mismatch password' do
    sign_up_with new_user.email, new_user.password, "not equal"
    expect(page).to have_content "Password not equal"
  end

  scenario 'invalid user with short password' do
    sign_up_with new_user.email, "1", new_user.password_confirmation
    expect(page).to have_content "Password is too short"
  end

  scenario 'invalid user without password' do
    sign_up_with new_user.email, "", new_user.password_confirmation
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'invalid user without password confirmation' do
    sign_up_with new_user.email, new_user.password, ""
    expect(page).to have_content "Password confirmation can't be blank"
  end

  scenario 'valid user' do
    sign_up_with new_user.email, new_user.password, new_user.password_confirmation
    expect(page).to have_content 'Verify'
  end
end