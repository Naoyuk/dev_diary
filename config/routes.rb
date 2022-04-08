Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/about'
  get '/signup', to: 'users#new'
  get '/profile', to: 'users#show'
  resources :users
end
