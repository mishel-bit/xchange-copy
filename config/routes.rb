Rails.application.routes.draw do
  
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
  
  get '/portfolio' => 'portfolio#index', as: 'portfolio'
  get '/transactions/:id' => 'transactions#index', as: 'transactions'
  get '/transactions' => 'transactions#show', as: 'show_transactions'
  get '/trade/:symbol' => 'trade#index', as: 'trade'
  post '/trade/:symbol/buy' => 'transactions#buy', as: 'buy_transaction'
  post '/trade/:symbol/sell' => 'transactions#sell', as: 'sell_transaction'

  get '/wallet' => 'wallet#index'
  post '/wallet' => 'wallet#deposit', :as => 'deposit'

  namespace :admin do
    resources :users
  end

  namespace :admin do
    get '/transactions' => 'transactions#index'
  end

end
