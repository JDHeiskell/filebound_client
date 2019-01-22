module FileboundClient
  module Endpoints
    # Module for Projects resource endpoint
    module Projects
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :project
          allow_all :projects
        end
      end

      # Retrieves a single project by its key
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request
      # @return [Project] project object
      def project(project_id, query_params = nil)
        get("/projects/#{project_id}", query_params)
      end

      # Retrieves fields for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String),
      #                                                                            includeProjectLinkOptions(bool))
      # @return [Array] array of fields
      def project_fields(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves files for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String))
      # @return [Array] array of files
      def project_files(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves groups for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String))
      # @return [Array] array of groups
      def project_groups(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves dividers for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String))
      # @return [Array] array of dividers
      def project_dividers(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves routed items for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String),
      #                                                                            userId(int), type(int))
      # @return [Array] array of routed items
      def project_routeditems(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves separators for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String))
      # @return [Array] array of separators
      def project_separators(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves assignments for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String))
      # @return [Array] array of assignments
      def project_assignments(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Retrieves routes for a project
      # @param [int] project_id the project key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter(String),
      #                                                                            xml(bool), hiddenRoutes(bool))
      # @return [Array] array of routes
      def project_routes(project_id, query_params = nil)
        get_project_children(project_id, __method__, query_params)
      end

      # Adds a project.  The project.ProjectId must be nil or 0.
      # @param [Project] project the project to add
      # @return [int] the id of the newly created project
      # @example Add a project
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.project_add(ProjectId: nil, Name: 'Test API Project', ProjectType: 'HR')
      def project_add(project)
        raise Client::FileboundClientException.new('Id is required', 0) if project[:projectId].greater_than_zero?
        put('/projects', nil, project)
      end

      # Edits a project.  The project.ProjectId must be not nil and > 0.
      # @param [Hash] project the project to edit
      # @return [int] the project id updated
      # @example Update an existing project
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.project_update(ProjectId: 165, Name: 'Test API Project', ProjectType: 'HR', EnableMultiKeySearch: true)
      def project_update(project)
        raise Client::FileboundClientException.new('Id is required', 0) unless project[:projectId].greater_than_zero?
        put('/projects', nil, project)
      end

      # Adds a divider to a project
      # @param [int] project_id the project key to add the divider to
      # @param [Hash] divider the divider hash to add to the project
      # @return [int] the divider id
      def project_divider_add(project_id, divider)
        put("/projects/#{project_id}/dividers", nil, divider)
      end

      # Adds a separator to a project
      # @param [int] project_id the project key to add the separator to
      # @param [Hash] separator the separator hash to add to the project
      # @return [int] the separator id
      def project_separator_add(project_id, separator)
        put("/projects/#{project_id}/separators", nil, separator)
      end

      # Adds a file to a project
      # @param [int] project_id the project key to add the file to
      # @param [Hash] file the file hash to add
      # @return [int] the file id created
      def project_file_add(project_id, file)
        put("/projects/#{project_id}/files", nil, file)
      end

      # Adds an array of files to a project
      # @param [int] project_id the project key to add the files to
      # @param [Array] files the array of file hashes to add
      # @return [Hash] true if adding the files was successful
      def project_files_add(project_id, files)
        put("/projects/#{project_id}/listfiles", nil, files)
      end

      # Deletes a project
      # @param [int] project_id the project key of the project to delete
      # @return [bool] true if deleting the project was successful
      def project_delete(project_id)
        delete("/projects/#{project_id}")
      end

      private

      def get_project_children(project_id, child_name, query_params = nil)
        get("/projects/#{project_id}/#{child_name.to_s.split('_')[1]}", query_params)
      end
    end
  end
end
