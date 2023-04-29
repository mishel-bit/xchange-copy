
require 'rails_helper'
RSpec.describe 'buy stock', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }

  scenario 'with enough balance' do
    sign_in_with user
    buy_stock("1")
    expect(page).to have_content "Successfully bought 1.0 shares"
  end

  scenario 'without enough balance' do
    sign_in_with user
    buy_stock("1000000")
    expect(page).to have_content "Purchase failed. You don't have enough balance"
  end

end