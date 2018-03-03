Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :audits, except: [:update, :destroy, :show, :edit]

  root to: "audits#index"
end
