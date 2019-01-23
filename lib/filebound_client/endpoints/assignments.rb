module FileboundClient
  module Endpoints
    # Module for Assignments resource endpoint
    module Assignments
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :assignment
          allow_all :assignments
        end
      end

      # Gets the projects that the user has assignments in
      # @param [Hash] query_params optional query params to pass to the request
      # @return [Array] array of assignments
      def assignments_projects(query_params = nil)
        get('/assignments/projects', query_params)
      end
    end
  end
end
