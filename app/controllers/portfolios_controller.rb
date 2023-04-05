class PortfoliosController < ApplicationController

  def index
    @portfolios = Portfolio.all
  end

  def show
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

  end

end
