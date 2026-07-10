Rails.application.routes.draw do
  devise_for :users

  root "items#index"

  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  get "up" => "rails/health#show", as: :rails_health_check
end