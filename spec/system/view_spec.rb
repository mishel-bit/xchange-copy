
require 'rails_helper'

RSpec.describe 'view', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user,:admin) }

  scenario 'home as guest' do
    visit root_path
    expect(page).to have_content 'Sign in'
  end

  scenario 'transactions as admin' do
    sign_in_with admin
    visit admin_transactions_path
    expect(page).to have_content 'Price'
  end
  
  scenario 'users as admin' do
    sign_in_with admin
    expect(page).to have_content 'Users'
  end

  scenario 'transactions as user' do
    sign_in_with user
    visit transactions_path
    expect(page).to have_content 'Price'
  end
  # new
  # scenario 'transactions according to stock as user' do
  #   sign_in_with user
  #   buy_stock("1")
  #   visit transactions_path(@user.stock.first)
  #   expect(page).to have_content @user.stock.first.symbol
  # end

  scenario 'wallet as user' do
    sign_in_with user
    click_on('Wallet')
    expect(page).to have_content 'Deposit'
  end

  scenario 'portfolio as user' do
    sign_in_with user
    click_on('Portfolio')
    expect(page).to have_content 'Holdings'
  end

end