require 'givdo/facebook/paginated_connections'

module Givdo
  module Facebook
    class Friends < PaginatedConnections
      def initialize(graph, params)
        super graph, 'friends', params
      end

      def users
        @users ||= User.for_provider_batch!(:facebook, list_with_picture)
      end

      private

      def list_with_picture
        list.map do |friend|
          friend.merge({'image' => "https://graph.facebook.com/#{friend['id']}/picture"})
        end
      end
    end
  end
end
