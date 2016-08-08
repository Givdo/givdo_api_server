Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/oauth/:action/callback', controller: :auth

      resources :activities, only: [:index]
      resources :friends, only: [:show, :index]
      resources :organizations, only: [:index]
      resource :user, only: [:update, :show]
      resources :devices, only: [:create]
      resources :causes, only: [:index, :create]

      resources :games, only: [] do
        resources :answers, only: [:create]
        resource :player, only: [:update]

        collection do
          get '/single', action: :single
          get '/versus/:uid', action: :versus
        end
      end

      resources :notifications, only: [:index] do
        member do
          put :accept
          put :reject
        end
      end
    end
  end
end
