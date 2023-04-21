class TradeController < ApplicationController
  before_action :get_user
    layout 'stacked'

    def index
        @chart_stock = get_chart_data
        @quote = IEX_CLIENT.quote(params[:symbol])
        @company = IEX_CLIENT.company(params[:symbol])
    end

    def get_chart_data
        @chart = IEX_CLIENT.chart(params[:symbol])
    
        chart_arr = @chart.reduce([]) { |init, curr|
          init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);
        }.inject({}) do |res, k|
          res[k[0]] = k[1..-1]
        res
        end
    end

    def get_user
      @user = User.find_by_email(cookies.encrypted[:user_id])
    end
end
