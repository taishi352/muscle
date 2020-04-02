Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :users,only: [:index, :show, :edit, :update] do
    get :about, on: :collection
    member do
      get :follows
      get :followers
    end
  end
  resources :scorings,only: [:edit, :update]
  resources :genres,only: [:new, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :posts,only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
end
