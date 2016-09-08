require 'givdo/facebook/paginated_connections'

module Givdo
  module Facebook
    USER_FIELDS = [:name, :email, :cover]

    class Friends < PaginatedConnections
      def initialize(graph, params)
        super graph, 'friends', params.merge(fields: USER_FIELDS)
      end

      def users
        @users ||= Givdo::Facebook::User.list list
      end
    end
  end
end
