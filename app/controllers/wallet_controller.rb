class WalletController < ApplicationController
    before_action :restrict_users, :restrict_admin
    layout 'stacked'

    def index
        @balance = @user.balance
    end

    def deposit
        @balance = @user.balance
        @user.deposit!(money_params)
        @balance = @user.balance
        redirect_to wallet_path, notice: "Deposit Successful"
    end
    
    private
    
    def money_params
        params.permit(:money)
    end
    
end
