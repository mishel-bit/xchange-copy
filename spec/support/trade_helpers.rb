module TradeHelpers
    def buy_stock(amount)
        visit trade_path('TSLA')
        fill_in 'buy amount', with: amount
        click_on('Buy')
    end

    def sell_stock(amount)
        visit trade_path('TSLA')
        fill_in 'sell amount', with: amount
        click_on('Sell')
    end
end
