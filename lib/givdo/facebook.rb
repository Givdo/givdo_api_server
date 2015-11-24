module Givdo
  module Facebook
    def self.oauth
      @_oauth ||= begin
        credentials = Rails.application.secrets.facebook.values_at('app_id', 'secret')
        Koala::Facebook::OAuth.new *credentials
      end
    end

    def self.graph(user=nil)
      token = user ? user.provider_access_token : oauth.get_app_access_token
      Koala::Facebook::API.new token
    end
  end
end
