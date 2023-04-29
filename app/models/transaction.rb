class Transaction < ApplicationRecord
    validates(:symbol, :price, :amount, :stock_id, presence: true)
    belongs_to :stock
end
