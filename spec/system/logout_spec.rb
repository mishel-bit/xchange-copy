
require 'rails_helper'

RSpec.describe 'logout', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }

  scenario 'user' do
    sign_in_with user
    click_on('Sign out')
    expect(page).to have_content 'Sign in'
  end

end