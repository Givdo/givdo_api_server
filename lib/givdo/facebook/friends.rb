require 'givdo/facebook/paginated_connections'

module Givdo
  module Facebook
    class Friends < PaginatedConnections
      def initialize(graph, params)
        super graph, 'friends', params
      end

      def users
        @users ||= begin
          uids = list.map{|friend| friend['id']}
          User.for_provider_batch!(:facebook, uids)
        end
      end
    end
  end
end
