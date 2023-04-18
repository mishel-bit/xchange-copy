class TransactionsController < ApplicationController
    
    def index
    end

    def show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    private

    def get_portfolio
        if params[:stock_symbol]
            $company.symbol 
        end 
    end

    def transaction_params
        params.require(:prortfolio_id).permit(:symbol, :price, :amount, :action)
    end
end
