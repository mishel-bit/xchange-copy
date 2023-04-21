module PortfoliosHelper
    def company(symbol)
        IEX_CLIENT.company(symbol)
    end
end
