module TransactionHelper
    def symbol(portfolio_id)
        Portfolio.find(portfolio_id).symbol
    end
end
