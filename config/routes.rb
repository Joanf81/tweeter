Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do  # /api/v1/..

      # User routes
      resources :users, except: [:new, :edit, :destroy]
      get 'users/:id/tweets', :to => "users#tweets"

      # Tweet routes
      resources :tweets, except: [:new, :edit]
      get 'tweets/:id/tags', :to => "tweets#tags"
      post 'tweets/:id/tags', :to => "tweets#addtag"
      delete 'tweets/:id/tags/:idtag', :to => "tweets#deletetag"

      # Tag routes
      resources :tags, only: [:index]
      get 'tags/:id/tweets', :to => "tags#tweets"

    end
  end

  get 'index', :to => "index#index"

  root :to => "index#index"
  get '*path' => redirect('/') unless Rails.env.development?
end
