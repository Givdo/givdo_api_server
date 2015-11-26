Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      mount_devise_token_auth_for 'User', :at => 'auth', :controllers => {
        :omniauth_callbacks => 'oauth_callback',
      }

      resources :trivia, :only => [:show] do
        member do
          post '/answer', :action => :answer
        end
        collection do
          get '/raffle', :action => :raffle
        end
      end
      resources :organizations, :only => [:index]
      resources :friends, :only => [:index]
      resources :payments, :only => [:create] do
        collection do
          get '/token', :action => :token
        end
      end
    end
  end
end
