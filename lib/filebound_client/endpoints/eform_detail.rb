module FileboundClient
  module Endpoints
    # Module for EFormDetail resource endpoint
    module EFormDetail
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :eformdetail
          allow_all :eformdetail
        end
      end
    end
  end
end
