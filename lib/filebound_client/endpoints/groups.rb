module FileboundClient
  module Endpoints
    # Module for Groups resource endpoint
    module Groups
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :group
          allow_all :groups
        end
      end

      # Retrieves a single group by its key
      # @param [int] group_id the group key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter)
      # @return [Hash] the group hash
      def group(group_id, query_params = nil)
        get("/groups/#{group_id}", query_params)
      end

      # Retrieves projects assigned to the group
      # @param [int] group_id the group key
      # @param [Hash] query_params additional query params to send in the request (option params: filter)
      # @return [Hash] the group hash
      def group_projects(group_id, query_params = nil)
        get("/groups/#{group_id}/projects", query_params)
      end
    end
  end
end