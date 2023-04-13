Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  
  get '/sign_in' => 'session#sign_in'
  post '/sign_in' => 'session#new_session'
  delete '/logout' => 'session#logout'

  get '/sign_up' => 'user#sign_up'
  post '/sign_up' => 'user#new_account'

    namespace :admin do
      resources :users
    end

  get '/portfolios' => 'portfolios#index'
  get '/portfolios/show' => 'portfolios#show', as: 'show_portfolio'
 
end
