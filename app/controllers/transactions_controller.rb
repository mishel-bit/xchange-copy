class TransactionsController < ApplicationController
    before_action :get_user
    layout 'stacked'

    def index
        @portfolio = Portfolio.find(params[:id])
        # @transaction = @portfolio.transactions
        @transaction = Transaction.where(portfolio_id: params[:id])
    end

    def buy
      @portfolio = @user.portfolios.find_by_symbol(params[:symbol]) 
        if @portfolio.nil?
          @portfolio = @user.portfolios.create(:symbol => params[:symbol], :amount => 0, :company_name  => portfolio_params[:company_name]) 
        else
          total_price = transaction_params[:amount].to_d * transaction_params[:price].to_d
          print "teal"
          print transaction_params[:price]
          print @user.balance
          print total_price
          print @user
          if @user.balance < total_price
            redirect_to trade_path(params[:symbol]), notice: "Transaction failed. You don't have enough balance"
          else
            @user.update!(:balance => @user.balance - total_price)
            @portfolio.update!(:amount => @portfolio.amount + transaction_params[:amount].to_d)
            @transaction = @portfolio.transactions.new(transaction_params)
            if @transaction.save
              redirect_to trade_path(params[:symbol]), notice: "Transaction Successful"
            else
              redirect_to trade_path(params[:symbol]), notice: "Transaction Failed"
            end
          end
        end
    end
    
    def sell
      @portfolio = @user.portfolios.find_by_symbol(params[:symbol]) 
        if @portfolio.nil?
          @portfolio = @user.portfolios.create(:symbol => params[:symbol], :amount => 0, :company_name  => portfolio_params[:company_name]) 
        else
          total_price = transaction_params[:amount].to_d * transaction_params[:price].to_d
          if @portfolio.amount < transaction_params[:amount].to_d 
            redirect_to trade_path(params[:symbol]), notice: "Transaction failed. You don't have enough shares"
          else
            @user.update!(:balance => @user.balance + total_price)
            @portfolio.update!(:amount => @portfolio.amount - transaction_params[:amount].to_d)
            @transaction = @portfolio.transactions.new(transaction_params)
            if @transaction.save
              redirect_to trade_path(params[:symbol]), notice: "Transaction Successful"
            else
              redirect_to trade_path(params[:symbol]), notice: "Transaction Failed"
            end
          end
        end
    end
    
    private

    def transaction_params
      params.permit(:symbol, :price, :amount, :transaction_kind)
    end

    def portfolio_params
      params.permit(:company_name)
    end

    def get_user
      @user = User.find_by_email(cookies.encrypted[:user_id])
    end

end
