class HomeController < ApplicationController
 before_action :get_user
 layout 'single_column'

 def index
    # @stocks_active = IEX_CLIENT.stock_market_list(:mostactive) 
    # @stocks_gainers = IEX_CLIENT.stock_market_list(:gainers) 
    # @stocks_losers = IEX_CLIENT.stock_market_list(:losers) 
    @stocks_cloud = IEX_CLOUD
    @stocks_array = Kaminari.paginate_array(@stocks_cloud, total_count:@stocks_cloud.count).page(params[:page]).per(10)
 end


 



 private



 def get_user
     @user = User.find_by_email(cookies.encrypted[:user_id])
    
     if @user.admin?
        redirect_to admin_users_path
     end
 end
end
