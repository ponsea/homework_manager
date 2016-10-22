Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'top#index'
  get '/top/login', to: 'top#login'
  post '/top/auth', to: 'top#auth'
  resource :user
end
