Rails.application.routes.draw do

  resources :tweets
  namespace 'api' do
    namespace 'v1' do  # /api/v1/..

      # User routes
      resources :users, except: [:new, :edit, :destroy]
      get 'users/:id/tweets', :to => "users#tweets"

      # Tweet routes
      resources :tweets, except: [:new, :edit]

    end
  end

  get 'index', :to => "index#index"
  root :to => "index#index"
end
