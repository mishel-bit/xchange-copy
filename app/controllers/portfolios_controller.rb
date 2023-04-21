class PortfoliosController < ApplicationController
  before_action :get_portfolio
  before_action :get_user

  def index
    @portfolio = @user.portfolios
  end

  def show
    @chart_stock = get_chart_data
    @portfolio = Portfolio.new
    #for refactor 
    if params[:stock_symbol]
      @setportfolio = Portfolio.find_by(symbol: params[:stock_symbol])
    end
  end

  def new
    @portfolio = @user.portfolios.new
  end

  def edit
  end

  def create
    @portfolio = @user.portfolios.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
          format.turbo_stream do
             render turbo_stream: [
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
      @portfolio = Portfolio.where(symbol: params[:stock_symbol])
      end
  end

  def portfolio_params
    params.require(:portfolio).permit(:symbol, :company_name, :amount)
  end



  def get_user
    @user = User.find_by_email(cookies.encrypted[:user_id])
  end

  def get_chart_data
    chart = IEX_CLIENT.chart(params[:stock_symbol])

    chart_arr = chart.reduce([]) { |init, curr|
      init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);
    }.inject({}) do |res, k|
      res[k[0]] = k[1..-1]
    res
    end
  end

end
