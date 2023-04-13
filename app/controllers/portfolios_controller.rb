class PortfoliosController < ApplicationController


  def index
    @portfolios = Portfolio.all
    
  end

  def show
    @chart_stock = get_chart_data
  end

  def new
    @portfolio = Portfolio.new
  end

  def edit
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      redirect_to portfolios_path, notice: "New stocks has been added to Portfolio"
    else
      render :new, notice: :unproccessable_entity
    end
  end

  def update
  end

  private

  def portfolio_params
    params.require(:stock_symbol)
  end

  def get_symbol
    @symbol = Portfolio.find(params[:stock_symbol])
  end

  def get_chart_data
    @client = IEX::Api::Client.new(
      publishable_token: 'pk_06f0670b09884fe5aa66d394e4263f00',
      secret_token: 'sk_f528b0c334f24d498705a205d72a7ec4',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    @chart = @client.chart(params[:stock_symbol])

    chart_arr = @chart.reduce([]) { |init, curr|
      init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);
    }.inject({}) do |res, k|
      res[k[0]] = k[1..-1]
    res
    end
  end

end
