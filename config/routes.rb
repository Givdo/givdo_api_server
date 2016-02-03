Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      post '/oauth/:action/callback', :controller => 'oauth_callback'

      resources :games, :only => [:create] do
        resource :player, :only => [:update], :controller => :player
        resources :answers, :only => [:create]
        collection do
          get '/single', :action => :single
        end
        member do
          get '/raffle', :action => :raffle
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
