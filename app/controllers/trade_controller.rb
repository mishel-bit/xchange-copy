class TradeController < ApplicationController
    layout 'stacked'

    def index
        @chart_stock = get_chart_data
        @quote = IEX_CLIENT.quote(params[:symbol])
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
end
