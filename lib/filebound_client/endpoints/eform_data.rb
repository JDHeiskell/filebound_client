module FileboundClient
  module Endpoints
    # Module for EFormData resource endpoint
    module EFormData
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :eformdata
          allow_all :eformdata
        end
      end
    end
  end
end
