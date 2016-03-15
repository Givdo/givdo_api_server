module Givdo
  module TokenAuth
    class Session
      include ActiveModel::Model
      include ActiveModel::Serialization
      attr_accessor :user

      def initialize(user, exp)
        @user, @exp = user, exp
      end

      def token
        @token ||= begin
          data = {:data => user.to_sgid.to_s, :exp => @exp}
          JWT.encode(data, *Config)
        end
      end
    end
  end
end
