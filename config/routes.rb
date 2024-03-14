Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  resources :projects do
    resources :notes
    resources :tasks do
      member do
        patch :toggle
      end
    end
    patch :complete, on: :member
  end

  namespace :api do
    resources :projects#, only: [:index, :show, :create]
  end

  root "home#index"
end
