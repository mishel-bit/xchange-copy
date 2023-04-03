Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  
  get '/sign_in' => 'auth#sign_in'
  get '/sign_up' => 'auth#sign_up'
  post '/sign_in' => 'auth#new_session'
  post '/sign_up' => 'auth#new_account'
  delete '/logout' => 'auth#logout'
end
