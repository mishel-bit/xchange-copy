Rails.application.routes.draw do

  root "home#index"
  
  get '/sign_in' => 'session#sign_in'
  post '/sign_in' => 'session#new_session'
  delete '/logout' => 'session#logout'

  get '/verify' => 'user#verify'
  post '/verify' => 'user#verify_email'
  
  get '/forgot_password' => 'user#forgot_password'
  post '/forgot_password' => 'user#password_reset_email'
  get '/reset_password/:token' => 'user#reset_password'
  patch '/reset_password/:token' => 'user#update_password', :as => 'reset_password'
  
  get '/sign_up' => 'user#sign_up'
  post '/sign_up' => 'user#new_account'
  
    namespace :admin do
      resources :users
    end

end
