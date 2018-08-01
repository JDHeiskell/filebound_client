module FileboundClient
  module Endpoints
    # Module for Dividers resource endpoint
    module Dividers
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :divider
          allow_all :dividers
        end
      end
    end
  end
end
