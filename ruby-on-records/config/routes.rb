Rails.application.routes.draw do
  # === Autenticación === #
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # === Backstore/Admin (requiere login) === #
  namespace :admin do
    root to: "dashboard#index"
    resources :disks
    resources :sales
    resources :users
    resources :clients
    resources :genres
    resources :items
  end

  # === Storefront (público) === #
  root "storefront#index"
  resources :disks, only: [:index, :show]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
