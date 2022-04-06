Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  get 'static_pages/home'
  get 'static_pages/about'
  root 'static_pages#home'
end
