class HomeController < ApplicationController
 before_action :get_user

 def index
    @client = IEX::Api::Client.new(
        publishable_token: 'pk_06f0670b09884fe5aa66d394e4263f00',
        endpoint: 'https://cloud.iexapis.com/v1'
      )
    @all = @client.stock_market_list(:mostactive)
 end

 private
 def get_user
     @user = User.find_by_email(cookies.encrypted[:user_id])
    
     if @user.admin?
        redirect_to admin_users_path
     end
 end
end
