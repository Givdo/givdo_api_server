require 'givdo/facebook/friends'

module Givdo
  module Facebook
    def self.oauth
      @_oauth ||= begin
        credentials = Rails.application.secrets.facebook.values_at('app_id', 'secret')
        Koala::Facebook::OAuth.new *credentials
      end
    end

    def self.graph(user_token=nil)
      token = user_token || oauth.get_app_access_token
      Koala::Facebook::API.new token
    end

    def self.friends(user, params)
      Friends.new(graph(user.provider_token), params)
    end
  end
end
