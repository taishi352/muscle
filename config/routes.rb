Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :users,only: [:index, :show, :edit, :update]
  resources :scorings,only: [:edit, :update]
  resources :posts do
  	resource :favorites, only: [:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
end
