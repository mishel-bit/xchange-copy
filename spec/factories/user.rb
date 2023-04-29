FactoryBot.define do
    factory :user, class: 'User' do
        email {  Faker::Internet.email }
        password { 'password' }
        password_confirmation { 'password' }
        admin { false }
        email_confirmed { true }
        account_status { 'approved' }
    end

    trait :admin do
        email { 'admin@admin.email' }
        password { 'admin1234567890' }
        password_confirmation { 'admin1234567890' }
        admin { true }
    end

    trait :not_verified do
        email_confirmed { false }
    end

    trait :pending do
        account_status { 'pending' }
    end

    trait :new do
        email_confirmed { false }
        account_status { 'pending' }
    end
end