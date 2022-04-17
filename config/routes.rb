Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :sessions
    resources :lists
  end
  get 'home/index'
  get '*path', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
