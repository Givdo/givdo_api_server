module Givdo
  module TokenAuth
    class Session
      include ActiveModel::Model
      include ActiveModel::Serialization
      attr_accessor :user

      def initialize(user, exp_in)
        @user, @exp_in = user, exp_in
      end

      def token
        @token ||= begin
          data = {:data => user.to_sgid.to_s, :exp => exp}
          JWT.encode(data, *Config)
        end
      end

      private

      def exp
        @exp_in.to_i.seconds.from_now.to_i if @exp_in
      end
    end
  end
end
