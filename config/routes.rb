Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      post '/oauth/:provider/callback' => 'oauth_callback#callback'

      resources :games, :only => [:create] do
        resources :answers, :only => [:create]
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
    end
  end
end
