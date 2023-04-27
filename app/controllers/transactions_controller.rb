class TransactionsController < ApplicationController
    before_action :restrict_users, :restrict_admin
    layout 'stacked'

    def index
        if params[:id].blank?
          @transactions = Transaction.where(stock_id: @user.stock_ids)
        else
          @transactions = Transaction.where(stock_id: params[:id])
        end
    end
    
    def create
      @user_stock = @user.stocks.find_by_symbol(params[:symbol]) 
      if @user_stocks.nil?
        @user_stock = @user.stocks.create(symbol: params[:symbol], amount: 0, company_name: stock_params[:company_name]) 
      end

      total_price = transaction_params[:amount].to_d * transaction_params[:price].to_d
      category = params[:category]

      if category === "buy"
        if @user.balance < total_price
          redirect_to trade_path(params[:symbol]), notice: "Purchase failed. You don't have enough balance"
        else
          @user.update!(:balance => @user.balance - total_price)
          @user_stock.update!(:amount => @user_stock.amount + transaction_params[:amount].to_d)
          @transaction = @user_stock.transactions.new(transaction_params)
          if @transaction.save
            redirect_to trade_path(params[:symbol]), notice: "Successfully bought #{transaction_params[:amount].to_d } shares"
          else
            redirect_to trade_path(params[:symbol]), notice: "Purchase Failed"
          end
        end  
      #sell stocks
      else
        if @user_stock.amount < transaction_params[:amount].to_d 
          redirect_to trade_path(params[:symbol]), notice: "Sell failed. You don't have enough shares"
        else
          @user.update!(:balance => @user.balance + total_price)
          @user_stock.update!(:amount => @user_stock.amount - transaction_params[:amount].to_d)
          @transaction = @user_stock.transactions.new(transaction_params)
          if @transaction.save
            redirect_to trade_path(params[:symbol]), notice: "Successfully sold #{transaction_params[:amount].to_d } shares"
          else
            redirect_to trade_path(params[:symbol]), notice: "Sell Failed"
          end
        end
      end
    end
    
    private

    def transaction_params
      params.permit(:symbol, :price, :amount, :transaction_kind)
    end

    def stock_params
      params.permit(:company_name)
    end
end
