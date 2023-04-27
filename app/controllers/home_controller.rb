class HomeController < ApplicationController
  before_action :restrict_users, :restrict_admin
  layout 'stacked'

  def index
    @stocks_active = IEX_CLIENT.stock_market_list(:mostactive).sort_by(&:latest_volume).reverse
    @latest_date = @stocks_active.last.latest_update_t
    @stocks_gainers = IEX_CLIENT.stock_market_list(:gainers).sort_by(&:change_percent).reverse
    @stocks_decliners = IEX_CLIENT.stock_market_list(:losers).sort_by(&:change_percent)
    @stocks_cloud = Api::Iex::Cloud.call
    @stocks_array = Kaminari.paginate_array(@stocks_cloud, total_count:@stocks_cloud.count).page(params[:page]).per(10)
  end

end
