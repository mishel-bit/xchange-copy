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

  def addnew
    @portfolio = Portfolio.new(portfolio_params)
    respond_to do |format|
      if @portfolio.save
          format.turbo_stream do
             render turbo_stream: [
              turbo_stream.update("frame1", partial: "add_portfolio")
             ] 
          end
      else
          render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
          format.turbo_stream do
             render turbo_stream: [
             # turbo_stream.update("sidepanel", partial: "sidepanel" ,locals: {symbol: @portfolios}),
              turbo_stream.update("modal", "")
             ] 
          end
      else
          render :new, status: :unprocessable_entity
      end
    end
  end

  def update
  end

  private

  def get_portfolio
    if params[:stock_symbol]
    @portfolio = Portfolio.find(:symbol => params[:stock_symbol])
    end
  end



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
