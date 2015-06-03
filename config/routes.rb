Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :categories
  resources :tags
  resources :comments
  root 'posts#index'
  get '/contact' => 'welcome#contact'
  get '/cat' => 'api#categories'
  post '/records' => 'api#video'
  get '/search' => 'posts#search'
  get '/check/*email' => 'api#email'
  get '/video' => 'api#videocheck'
end