Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      mount_devise_token_auth_for 'User', :at => 'auth'

      resources :trivia
      resources :organizations, :only => [:index]
      resources :payments, :only => [:create] do
        get '/token', :action => :token, :on => :collection
      end
    end
  end
end
