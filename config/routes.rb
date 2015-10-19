Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      resources :organizations, only: [:index]
    end
  end
end

