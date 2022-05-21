Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :sessions
    resources :lists ,shallow: true do
      resources :favorites, only: %i[create destroy]
      collection do
        get 'userlists'
        get 'aboutlists'
        get :favorites
      end
    end
    resources :favorites , only: %i[index]
    resources :tags
    resources :videos
    resources :comments
    resources :profile
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    get '*path', to: 'home#index', constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
end
