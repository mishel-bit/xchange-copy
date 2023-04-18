class HomeController < ApplicationController
 before_action :get_user
 $client = IEX::Api::Client.new(
  publishable_token: 'pk_06f0670b09884fe5aa66d394e4263f00',
  secret_token: 'sk_f528b0c334f24d498705a205d72a7ec4',
  endpoint: 'https://cloud.iexapis.com/v1'
)
 def index
  #  $stocks = show_stocks

  @show = $client.stock_market_list(:mostactive)
 end

#  def show_stocks
#   response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
#   JSON.parse(response.body)
#  end




 private



 def get_user
     @user = User.find_by_email(cookies.encrypted[:user_id])
    
     if @user.admin?
        redirect_to admin_users_path
     end
 end
end
