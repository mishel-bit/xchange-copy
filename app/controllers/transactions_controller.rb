class TransactionsController < ApplicationController
    before_action :get_portfolio
    before_action :get_transaction, only: [ :show, :edit, :update, :destroy ]
    before_action :get_user
    def index
        @transaction = @portfolio.transactions
    end

    def show
    end

    def new
       @trans = params[:transaction]
       @chart_stock = get_chart_data
       @transaction = @portfolio.transactions.new
       @logo = $client.logo(@portfolio.symbol)
       @quote = $client.quote(@portfolio.symbol)
       $company = $client.company(@portfolio.symbol)
    end

    def create
        @transaction = @portfolio.transactions.new(transaction_params)
        if @transaction.save
          
          redirect_to portfolio_transactions_path, notice: 'New transaction has been completed!'
        else
          render :new, notice: :unproccessable_entity
        end
    end

    def edit
    end

    def update
    end

    private

    
    def get_portfolio   
        @portfolio = Portfolio.find(params[:portfolio_id])
    end

    def get_transaction
        @transaction = Transaction.find(params[:id])
    end

    def transaction_params
        params.fetch(:transaction, {}).permit(:symbol, :price, :amount, :transaction_kind, :portfolio_id)
    end

    def get_chart_data
        @chart = $client.chart(@portfolio.symbol)
    
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
