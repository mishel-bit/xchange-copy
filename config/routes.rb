Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "home#index"
  
  get '/sign_in' => 'session#sign_in'
  post '/sign_in' => 'session#new_session'
  delete '/logout' => 'session#logout'

  get '/verify' => 'user#verify'
  post '/verify' => 'user#verify_email'
  post '/resend' => 'user#resend_code'
  
  get '/forgot_password' => 'user#forgot_password'
  post '/forgot_password' => 'user#password_reset_email'
  get '/reset_password/:token' => 'user#reset_password'
  patch '/reset_password/:token' => 'user#update_password', :as => 'reset_password'
  
  get '/sign_up' => 'user#sign_up'
  post '/sign_up' => 'user#new_account'
  
  get '/account' => 'user#account_show'
  post '/account' => 'user#account_edit'
  
    namespace :admin do
      resources :users
    end

    resources :portfolios do
      resources :transactions
      end

  get '/portfolios' => 'portfolios#index'
  get '/portfolios/show' => 'portfolios#show', as: 'show_portfolio'

end
