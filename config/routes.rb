Rails.application.routes.draw do

  root 'users#index'
  resources :users
  resources :sessions, only:[:new,:create,:destroy]

  resources :scores do
    resources :comments, only:[:create, :destroy] do
    end
  end

  resources :courses, only:[:index,:show]
end
