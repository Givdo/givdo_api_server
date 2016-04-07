Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  scope '/api' do
    scope '/v1' do
      post '/oauth/:action/callback', :controller => 'oauth_callback'

      resource :user, :only => [:update, :show]
      resources :activities, only: [:index]

      resources :games, :only => [] do
        resource :player, :only => [:update], :controller => :player
        resources :answers, :only => [:create]
        collection do
          get '/single', :action => :single
          get '/versus/:uid', :action => :versus
        end
      end

      resources :organizations, :only => [:index]
      resources :payments, :only => [:create] do
        collection do
          get '/token', :action => :token
        end
      end

      resources :friends, :only => [:index]
    end
  end
end
