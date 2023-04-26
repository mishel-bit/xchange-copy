class WalletController < ApplicationController
    before_action :restrict_users, :restrict_admin
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
    
    def money_params
        params.permit(:money)
    end
    
end
