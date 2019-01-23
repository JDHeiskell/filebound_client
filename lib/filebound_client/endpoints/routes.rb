module FileboundClient
  module Endpoints
    # Module for Routes resource endpoint
    module Routes
      def self.included(klass)
        klass.instance_eval do
          allow_new :route
          allow_all :routes
        end
      end

      # Retrieves xml for a route
      # @param [int] route_id the route key
      # @param [Hash] query_params additional query params to send in the request
      # @return [string] string of xml representing route
      def route_xml(route_id, query_params = nil)
        get("/routes/#{route_id}/xml", query_params)
      end

      # Routes a document to the start of a workflow
      # @param [long] route_id the route key
      # @param [int] document_id the document key to route
      # @param [string] notes optional notes to from the user who started the document down the route
      # @return [RoutedItem] a hash of the RoutedItem resource that was added
      def route_document_to_workflow(route_id, document_id, notes)
        params = { documentId: document_id }
        params[:notes] = notes if notes
        put("/routes/#{route_id}", params, nil)
      end

      # Routes a document to a specified step
      # @param [long] routed_item_id the RoutedItem key
      # @param [int] step_number the step number to route to
      # @param [string] comment optional comment for the step
      # @param [DateTime] due_date optional due date for the routed item
      # @param [long] user_id optional; if reassigning this the user id to reassign to
      # @param [string] checklist_data optional comma-seperated checklist values
      # @param [long] route_step_id optional RouteStep key
      # @param [long] route_step_task_id options RouteStepTask key
      # @return [nil]
      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/ParameterLists
      def route_document_to_step(routed_item_id, step_number, comment:, due_date:, user_id:, checklist_data:,
                                 route_step_id:, route_step_task_id:)
        params = { id: routed_item_id, stepNumber: step_number }
        params[:comment] = comment if comment
        params[:dueDate] = due_date if due_date
        params[:userId] = user_id if user_id
        params[:checklistData] = checklist_data if checklist_data
        params[:routeStepId] = route_step_id if route_step_id
        params[:routeStepTaskId] = route_step_task_id if route_step_task_id
        put('/routes', params, nil)
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/ParameterLists

      # Routes a document to a user
      # @param [long] document_id document key to route
      # @param [long] user_id user key to route to
      # @param [bool] route_back whether to route the document back when completed
      # @param [DateTime] due_date due date for the document
      # @return [nil]
      def route_document_to_user(document_id, user_id, route_back, due_date)
        params = { documentId: document_id, userId: user_id, routeBack: route_back, dueDate: due_date }
        put('/routes', params, nil)
      end
    end
  end
end
