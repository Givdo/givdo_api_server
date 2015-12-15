Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      post '/oauth/:provider/callback' => 'oauth_callback#callback'

      resources :games, :only => [:create]
      resources :trivia, :only => [:show] do
        member do
          post '/answer', :action => :answer
        end
        collection do
          get '/raffle', :action => :raffle
        end
      end
      resources :organizations, :only => [:index]
      resources :friends, :only => [:index] do
        collection do
          post '/invite', :action => :invite
        end
      end
      resources :payments, :only => [:create] do
        collection do
          get '/token', :action => :token
        end
      end
    end
  end
end
