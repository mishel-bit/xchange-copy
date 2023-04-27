module TransactionHelper
    def symbol(stock_id)
        Stock.find(stock_id).symbol
    end
end
