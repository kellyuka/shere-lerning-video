Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :sessions
    resources :lists do
      collection do
        get 'userlists'
      end
    end
    resources :tags
    resources :videos
    resources :comments
    resources :profile
  end
    get '*path', to: 'home#index', constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
end
