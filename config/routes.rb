Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'top#index'
  get 'top/login' => 'top#login'
  post 'top/auth' => 'top#auth'
  resource :user do
    patch 'logout' => 'users#logout'
  end
  resources :groups do
    collection { get 'search' }
    member do
      get 'reception' # グループ参加確認ページ
      post 'join'     # グループ参加処理
    end
    resources :tasks
    resources :grades, only: [:index, :create]
    resources :messages, only: [:index, :new, :create]
    resources :members, only: :index do
      collection { patch 'addmin'}  # 管理者を増やす処理
    end
    resources :users_tasks, only: [:index, :show, :update] do
      collection { patch 'confirm'} # タスク確認処理
    end
  end
end
