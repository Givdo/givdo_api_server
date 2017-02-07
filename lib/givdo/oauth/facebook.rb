module Givdo
  module Oauth
    class Facebook
      USER_FIELDS = 'id,name,cover,email'.freeze

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
        profile = graph.get_object('me', fields: USER_FIELDS)
        picture = graph.get_picture_data('me')
        cover = profile['cover'].try(:fetch, 'source')

        User.for_provider!(:facebook,  profile['id'], {
          cover: cover,
          image: picture['url'],
          name: profile['name'],
          email: profile['email'],
          provider_token: @access_token
        })
      end

      def graph
        @graph ||= Givdo::Facebook.graph(@access_token)
      end
    end
  end
end
