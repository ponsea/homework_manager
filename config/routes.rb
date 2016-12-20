Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'top#index'
  get 'top/login' => 'top#login'
  post 'top/auth' => 'top#auth'
  resource :user do
    patch 'logout' => 'users#logout'
    resources :groups do
      collection { get 'search' }
      member { post 'join' }
    end
  end
end
