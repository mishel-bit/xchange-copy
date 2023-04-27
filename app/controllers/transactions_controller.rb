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
      if @user_stock.nil?
        @user_stock = @user.stocks.create!(stock_params) 
      end
      category = params[:category]
      
      if category === "buy"
        if @user.insufficient_balance?(transaction_params)
          redirect_to trade_path(params[:symbol]), notice: "Purchase failed. You don't have enough balance"
        else
          @user.deduct_balance!(transaction_params)
          @user_stock.add_amount!(transaction_params)
          @transaction = @user_stock.transactions.new(transaction_params)
          if @transaction.save
            redirect_to trade_path(params[:symbol]), notice: "Successfully bought #{ @transaction.amount } shares"
          else
            redirect_to trade_path(params[:symbol]), notice: "Purchase Failed"
          end
        end  
      #sell stocks
      else
        if @user_stock.insufficient_amount?(transaction_params)
          redirect_to trade_path(params[:symbol]), notice: "Sell failed. You don't have enough shares"
        else
          @user.add_balance!(transaction_params) 
          @user_stock.deduct_amount!(transaction_params)
          @transaction = @user_stock.transactions.new(transaction_params)
          if @transaction.save
            redirect_to trade_path(params[:symbol]), notice: "Successfully sold #{ @transaction.amount } shares"
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
      params.permit(:symbol, :company_name)
    end

end
