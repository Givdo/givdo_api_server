#OmniAuth.config.logger = Rails.logger

FACEBOOK_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../facebook.yml', __FILE__))))

module Facebook
  APP_ID = FACEBOOK_CONFIG[:facebook][:app_id]
  SECRET = FACEBOOK_CONFIG[:facebook][:secret]
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Facebook::APP_ID, Facebook::SECRET
end
