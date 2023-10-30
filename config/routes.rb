Rails.application.routes.draw do
  resources :categories, except: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products, path: '/'

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
  end
end
