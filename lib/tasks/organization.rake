require 'facebook_graph'

include FacebookGraph

namespace :organization do
  desc "Cache data from Facebook API to database"
  task :cache => :environment do
    cache_organizations
  end
end
