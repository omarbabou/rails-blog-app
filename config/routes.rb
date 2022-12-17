Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root :to => "users#show", as: :authenticated_root
    end
    unauthenticated :user do
      root :to => "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:create, :destroy]
    resources :posts, only: [:index, :new,:create,:show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
  end
  end
  get "/posts/new", to: "posts#new"
  post "/posts/create", to: "posts#create"
  post "/users/:user_id/posts/:id/like", to: "likes#create"
  post "/users/:user_id/posts/:id/create_comment", to: "comments#create"
end