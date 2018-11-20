Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :authors, only: [:show, :destroy]
  resources :books,   only: [:index, :show, :new, :create, :destroy]
  resources :users,   only: [:show]
  resources :reviews, only: [:new, :create, :destroy]

end
