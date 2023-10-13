Rails.application.routes.draw do
  resources :enrollments
  resources :lessons
  devise_for :users
  
  get 'home/index'
  get 'home/activity'
  root 'home#index'
  
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]

  get 'static_pages/landing_page', as: "landing_page"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
