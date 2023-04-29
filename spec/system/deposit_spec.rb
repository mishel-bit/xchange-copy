
require 'rails_helper'
RSpec.describe 'deposit', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }

  scenario 'money' do
    sign_in_with user
    click_on('Wallet')
    fill_in 'Money', with: "100"
    click_on('Deposit')
    expect(page).to have_content "Deposit Successful"
  end

end