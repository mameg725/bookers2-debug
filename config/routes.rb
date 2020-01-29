Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'homes/top' => "homes#top"
  get 'homes/about' => "homes#about"
  resources :users,only: [:show,:index,:edit,:update,:create]
  resources :books,only: [:show,:index,:create,:edit,:update,:destroy] do
    resource :favorites,only: [:create, :destroy]
    resource :book_comments,only: [:create, :destroy]
  end
end