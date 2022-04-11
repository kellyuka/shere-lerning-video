Rails.application.routes.draw do
  get 'home/index'
  get '*path', to: 'home#index'
  namespace :api do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
