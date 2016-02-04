module Givdo
  module Facebook
    class PaginatedConnections < ActiveModelSerializers::Model
      delegate :next_page_params, :to => :list

      def initialize(graph, connections_name, params)
        @graph, @connections_name, @params = graph, connections_name, params || {}
      end

      def list
        @list ||= @params.has_key?(:page) ?
                    @graph.get_page(@params[:page]) :
                    @graph.get_connections('me', @connections_name, @params)
      end
    end
  end
end
