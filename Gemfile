source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.2.5'

# App Logic
gem 'koala', '~> 2.2'
gem 'active_model_serializers', :github => 'rails-api/active_model_serializers'
gem 'kaminari'
gem 'jwt'
gem 'activeadmin', :github => 'activeadmin'
gem 'devise' # Used for activeadmin only
gem 'ransack'
gem 'rpush'

# Others
gem 'rollbar'

# Importation
gem 'roo'

# External APIs
gem 'gibbon'

# App Server
gem 'unicorn'
gem 'rack-handlers'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'apitome'
  gem 'annotate'
  gem 'spring'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'pry-byebug'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :development do
  gem 'rails-erd'
  gem 'quiet_assets'
  gem 'rspec_api_documentation'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
