Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/index'
  resources :courses
  resources :users, only: [:index]

  get 'static_pages/landing_page', as: "landing_page"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
