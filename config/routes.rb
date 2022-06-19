Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :users, only: %i[create] do
      collection do
        get 'me'
      end
    end
    resources :sessions
    resources :lists ,shallow: true do
      resources :favorites, only: %i[create destroy]
    end
    resources :favorites , only: %i[index]
    resources :tags
    resources :videos
    resources :comments, only: %i[show create update destroy]
    resources :profile
    resources :password_resets, only: %i[create edit update]
  end
  get '/password_resets/:id/edit' , to: 'home#index', as: :edit_password_reset
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    get '*path', to: 'home#index', constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
end
