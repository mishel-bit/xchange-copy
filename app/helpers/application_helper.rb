module ApplicationHelper
    def quotes(symbol)
        IEX_CLIENT.quote(symbol)
    end

    def logo(symbol)
        IEX_CLIENT.logo(symbol)
    end

    def format_m(num)
        if !num.nil?
            (0.000001 * num).ceil(2)
        end
    end
end
