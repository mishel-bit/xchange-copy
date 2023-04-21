module Admin
    class TransactionsController < ApplicationController
        before_action :get_user
        def index
            @transactions = Transaction.all
        end

        def get_user
            @user = User.find_by_email(cookies.encrypted[:user_id])
            print @user.inspect
           
            if !@user.admin?
               redirect_to root_path
            end
        end
    end
end