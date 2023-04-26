class PortfolioController < ApplicationController
  before_action :restrict_users, :restrict_admin
  layout 'stacked'

  def index
    @portfolios = @user.portfolios
  end

end
