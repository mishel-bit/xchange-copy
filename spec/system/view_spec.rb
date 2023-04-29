
require 'rails_helper'

RSpec.describe 'view', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user,:admin) }

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