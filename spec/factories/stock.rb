FactoryBot.define do
    factory :stock, class: 'Stock' do
        association :user
        symbol {'TSLA' }
        company_name {'Tesla Inc'}
        amount {1}
    end
end