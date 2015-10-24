module Givdo
  module Facebook
    def self.oauth
      @_oauth ||= begin
        credentials = Rails.application.secrets.facebook.values_at('app_id', 'secret')
        Koala::Facebook::OAuth.new *credentials
      end
    end

    def self.graph
      Koala::Facebook::API.new oauth.get_app_access_token
    end

    def self.cache_organizations
      Organization.find_each do |organization|
        if organization.cached?
          puts "organization " + organization.name + " is already cached"
        else
          puts "caching organization with FB ID #{organization.facebook_id}"
          UpdateOrganizationJob.perform_later(organization)
          puts "organization #{organization.name} was cached successfully!"
        end
      end
    end
  end
end
