Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "home#index"
  
  get '/sign_in' => 'session#sign_in'
  post '/sign_in' => 'session#new_session'
  delete '/logout' => 'session#logout'

  get '/forgot_password' => 'user#forgot_password'
  post '/forgot_password' => 'user#password_reset_email'
  get '/reset_password/:token' => 'user#reset_password'
  patch '/reset_password/:token' => 'user#change_password', :as => 'reset_password'
  
  get '/sign_up' => 'user#sign_up'
  post '/sign_up' => 'user#new_account'
  
  # post '/reset_password' => 'user#reset_password'
    namespace :admin do
      resources :users
    end

end
