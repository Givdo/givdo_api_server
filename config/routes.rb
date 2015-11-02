Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      mount_devise_token_auth_for 'User', :at => 'auth'

      resources :trivia, :only => [:show] do
        member do
          post '/answer', :action => :answer
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
