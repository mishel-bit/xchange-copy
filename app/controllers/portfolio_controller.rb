class PortfolioController < ApplicationController
  before_action :restrict_users, :restrict_admin
  layout 'stacked'

  def index
    @user_stocks = @user.stocks
  end

end
