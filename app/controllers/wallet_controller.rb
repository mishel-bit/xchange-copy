class WalletController < ApplicationController
    before_action :get_user
    layout 'stacked'

    def index
        @balance = @user.balance
    end

    def deposit
        @balance = @user.balance
        print money_params[:money]
        @user.update!(:balance => @user.balance + money_params[:money].to_d)
        @balance = @user.balance
        redirect_to wallet_path, notice: "Deposit Successful"
    end
    
    private
    
    def get_user
        @user = User.find_by_email(cookies.encrypted[:user_id])
    end

    def money_params
        params.permit(:money)
    end
    
end
