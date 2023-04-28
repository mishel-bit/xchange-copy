
require 'rails_helper'

RSpec.describe 'sign in process', type: :system do
  let(:trader) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user,:admin) }
  # before :each do
  #   FactoryBot.create(trader)
  #   FactoryBot.create(admin)
  # end
  it 'sign in trader to xchange' do
    visit sign_in_path
    within('#new_session') do
      fill_in 'Email', with: trader.email
      fill_in 'Password', with: trader.password
    end
    click('Login to your account')
    visit root_path
  end
end