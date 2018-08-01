module FileboundClient
  module Endpoints
    # Module for Separators resource endpoint
    module Separators
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :separator
          allow_all :separators
        end
      end
    end
  end
end
