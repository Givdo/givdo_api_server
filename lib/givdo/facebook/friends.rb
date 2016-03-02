require 'givdo/facebook/paginated_connections'

module Givdo
  module Facebook
    class Friends < PaginatedConnections
      def initialize(graph, params)
        super graph, 'friends', params
      end

      def users
        @users ||= Givdo::Facebook::User.list list
      end
    end
  end
end
