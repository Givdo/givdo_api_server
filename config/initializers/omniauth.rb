Rails.application.config.middleware.use OmniAuth::Builder do
  credentials = Rails.application.secrets.facebook.values_at('app_id', 'secret')
  provider :facebook, *credentials,
	  :scope => 'email,user_friends,user_about_me'
end
