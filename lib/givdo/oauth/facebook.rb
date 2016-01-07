require 'givdo/facebook'

module Givdo
  module OAuth
    class Facebook
      def self.validate!(*args)
        new(*args).validate!
      end

      def initialize(access_token)
        @access_token = access_token
      end

      def validate!
        profile = graph.get_object('me')
        picture = graph.get_picture('me')

        User.for_provider!(:facebook,  profile['id'], {
          :image => picture,
          :name => profile['name']
        })
      end

      private

      def graph
        @graph ||= Givdo::Facebook.graph(@access_token)
      end
    end
  end
end
