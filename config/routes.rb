Rails.application.routes.draw do

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
  end


  resources :categories, except: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :favorites, only: [:create, :destroy, :index]
  resources :products, path: '/'
  resources :users, only: :show, path: '/user', param: :username
 
end
