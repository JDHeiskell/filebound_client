module FileboundClient
  module Endpoints
    # Module for Version resource endpoint
    module Version
      # Gets the API version
      # @return [String] the API version
      def api_version
        get('/version')
      end
    end
  end
end
