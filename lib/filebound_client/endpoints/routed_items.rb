module FileboundClient
  module Endpoints
    # Module for RoutedItems resource endpoint
    module RoutedItems
      def self.included(klass)
        klass.instance_eval do
          allow_new :routeditem
          allow_all :routeditems
        end
      end

      # Retrieves a single routed item by its key
      # @param [int] routed_item_id the routed item key
      # @param [Hash] query_params additional query params to send in the request
      # @return [Project] routed_item object
      def routed_item(routed_item_id, query_params = nil)
        get("/routeditems/#{routed_item_id}", query_params)
      end

      # Edits a routed item.  The routed_item.id must be not nil and > 0.
      # @param [Hash] routed_item the routed item to edit
      # @return [nil]
      # @example Update an existing routed item
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.routed_item_update(routed_item)
      def routed_item_update(routed_item)
        raise Client::FileboundClientException.new('Id is required', 0) unless routed_item[:id].greater_than_zero?
        post("/routeditems/#{routed_item[:id]}", nil, routed_item)
      end

      # Completes the current step for the routed item.  The routed_item.id must be not nil and > 0.
      # @param [int] routed_item_id the routed item key to update
      # @param [int] step_number the step number to route to
      # @param [string] step_caption the step caption for the step
      # @param [string] comment optional comment for the step
      # @param [DateTime] due_date optional due date for the routed item
      # @param [long] user_id optional; if reassigning this the user id to reassign to
      # @param [string] checklist_data optional comma-seperated checklist values
      # @param [long] route_step_id optional RouteStep key
      # @param [long] route_step_task_id options RouteStepTask key
      # @return [Array] array of RouteTask for the specified route step
      # @example Complete the current route step
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.routed_item_complete_step(routed_item)
      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/ParameterLists, Metrics/PerceivedComplexity
      def routed_item_complete_step(routed_item_id, step_number:, step_caption:, comment:, due_date:, user_id:,
                                    checklist_data:, route_step_id:, route_step_task_id:)
        raise Client::FileboundClientException.new('Id is required', 0) unless routed_item_id.greater_than_zero?
        params = {}
        params[:stepNumber] = step_number if step_number
        params[:stepCaption] = step_caption if step_caption
        params[:comment] = comment if comment
        params[:dueDate] = due_date if due_date
        params[:userId] = user_id if user_id
        params[:checklistData] = checklist_data if checklist_data
        params[:routeStepId] = route_step_id if route_step_id
        params[:routeStepTaskId] = route_step_task_id if route_step_task_id
        put("/routeditems/#{routed_item_id}/complete", params, nil)
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/ParameterLists, Metrics/PerceivedComplexity
    end
  end
end
