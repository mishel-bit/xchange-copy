module ApplicationHelper
    def quotes(symbol)
        IEX_CLIENT.quote(symbol)
    end

    def logo(symbol)
        IEX_CLIENT.logo(symbol)
    end

    def company(symbol)
        IEX_CLIENT.company(symbol)
    end

    def format_m(num)
        if !num.nil?
            (0.000001 * num).ceil(2)
        end
    end

    def format_date(date)
        if !date.nil?
            date.strftime("%b %d, %Y %I:%M %p %Z")
        end
    end

    def color(sign)
        if !sign.nil?
            sign === "+" ? 'text-emerald-600' : 'text-rose-600'
        end
    end
end
