class Stock < ApplicationRecord
    validates :symbol, uniqueness: { scope: :user_id }, presence: true
    belongs_to :user
    has_many :transactions

    def insufficient_amount?(transaction_params)
        self.amount < transaction_params[:amount].to_d
    end

    def add_amount!(transaction_params)
        self.amount += transaction_params[:amount].to_d

        self.save
    end

    def deduct_amount!(transaction_params)
        self.amount -= transaction_params[:amount].to_d
        
        self.save
    end
end
