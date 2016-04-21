module Givdo
  module TokenAuth
    extend ActiveSupport::Autoload

    autoload :Session

    Config = [Rails.application.secrets.secret_key_base, 'HS256']

    class InvalidToken < StandardError; end

    def self.recover(token)
      payload, headers = *JWT.decode(token, *Config)
      user = GlobalID::Locator.locate_signed(payload['data']) or raise InvalidToken
      Session.new(user, headers['exp'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      raise InvalidToken, e
    end
  end
end
