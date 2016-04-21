module Givdo
  module Oauth
    extend ActiveSupport::Autoload

    autoload :Facebook
    
    class Error < StandardError; end
  end
end
