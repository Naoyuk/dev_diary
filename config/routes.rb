# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pictures
  resources :images
  resources :posts
  get 'new/create'
  get 'new/destroy'
  root 'posts#index'
  get 'static_pages/home'
  get 'static_pages/about'
  get '/signup', to: 'users#new'
  get '/profile', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
end
