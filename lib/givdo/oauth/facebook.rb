module Givdo
  module Oauth
    class Facebook
      def self.validate!(*args)
        new(*args).validate!
      end

      def initialize(access_token)
        @access_token = access_token
      end

      def validate!
        update_user_data
      rescue Koala::Facebook::AuthenticationError => e
        raise Givdo::Oauth::Error, e
      end

      private

      def update_user_data
        profile = graph.get_object('me', :fields => 'id,name,cover')
        picture = graph.get_picture('me')

        User.for_provider!(:facebook,  profile['id'], {
          :image => picture,
          :cover => profile['cover'].try(:fetch, 'source'),
          :name => profile['name'],
          :provider_token => @access_token
        })
      end

      def graph
        @graph ||= Givdo::Facebook.graph(@access_token)
      end
    end
  end
end
