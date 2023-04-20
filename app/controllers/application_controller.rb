class ApplicationController < ActionController::Base
 protect_from_forgery with: :null_session

 before_action :authenticate_user  #:initialize_iex_client, :initialize_iex_cloud, :initialize_quote

 def root
 end 

 def current_user
    token = cookies.encrypted[:authorization]

    if token.present?
        user ||= User.find_by(token: token.gsub("Token", ""))
        cookies.encrypted[:user_id] = user.email
    end
 end

 def authenticate_user
     if current_user.nil?
         redirect_to sign_in_path
     end
 end

#  def initialize_iex_client
#     @client = IEX::Api::Client.new(
#         publishable_token: 'pk_06f0670b09884fe5aa66d394e4263f00',
#         secret_token: 'sk_f528b0c334f24d498705a205d72a7ec4',
#         endpoint: 'https://cloud.iexapis.com/v1'
#     )    
#  end

#  def initialize_iex_cloud
#     response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
#     @iex_client_cloud = JSON.parse(response.body, object_class: OpenStruct)
#  end

#  def initialize_quote
#     @quote = StockQuote::Stock.new(api_key: 'pk_06f0670b09884fe5aa66d394e4263f00')
#  end
 
end
