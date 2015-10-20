require 'givdo/facebook'

namespace :organization do
  desc "Cache data from Facebook API to database"
  task :cache => :environment do
    Givdo::Facebook.cache_organizations
  end
end
