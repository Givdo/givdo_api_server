Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :organizations, only: [:index]
      resources :payments, only: [] do
        collection do
          get '/token', action: :token
        end
      end
    end
  end
end
