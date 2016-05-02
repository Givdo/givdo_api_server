module Givdo
  class Error
    include ActiveModel::Model
    include ActiveModel::Serialization

    attr_accessor :status, :code, :title, :detail, :meta

    def initialize(params = {})
      super(params)

      @status = Rack::Utils::SYMBOL_TO_STATUS_CODE[params[:status]].to_s
    end
  end
end
