module Givdo
  module Facebook
    class Friends < PaginatedConnections
      def initialize(graph, params)
        super graph, 'invitable_friends', params
      end
    end
  end
end
