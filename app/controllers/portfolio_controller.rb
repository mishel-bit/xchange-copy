class PortfolioController < ApplicationController
  before_action :get_user

  def index
    @portfolio = @user.portfolios
  end

  def get_user
    @user = User.find_by_email(cookies.encrypted[:user_id])
  end

end
