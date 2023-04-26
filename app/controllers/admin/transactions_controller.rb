module Admin
    class TransactionsController < ApplicationController
        before_action :restrict_users, :restrict_user

        def index
            @transactions = Transaction.all
        end
    end
end