FactoryBot.define do
    factory :transaction, class: 'Transaction' do
        association :stock
        symbol {'TSLA' }
        price {100}
        amount {1}
    end
    
    trait :buy do
      transaction_kind { 'buy' }
    end
  
    trait :sell do
      transaction_kind { 'sell' }
    end
end