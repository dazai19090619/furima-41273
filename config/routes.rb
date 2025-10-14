Rails.application.routes.draw do
  # items#index へのルート
  root "items#index"

  # itemsコントローラの index アクションも明示的に残しておく場合
  get 'items/index'
  
  # health check
  get "up" => "rails/health#show", as: :rails_health_check
end
