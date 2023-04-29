
require 'rails_helper'
RSpec.describe 'sell stock', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }

  scenario 'with enough stock shares' do
    sign_in_with user
    buy_stock("1")
    sell_stock("1")
    expect(page).to have_content "Successfully sold 1.0 shares"
  end

  scenario 'without enough stock shares' do
    sign_in_with user
    buy_stock("1")
    sell_stock("2")
    expect(page).to have_content "Sell failed. You don't have enough shares"
  end

end