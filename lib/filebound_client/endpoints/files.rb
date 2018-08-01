module FileboundClient
  module Endpoints
    # Module for Files resource endpoint
    module Files
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :file
          allow_all :files
        end
      end

      # Retrieves a single file by its key
      # @param [int] file_id the file key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter)
      # @return [Hash] the file hash
      def file(file_id, query_params = nil)
        get("/files/#{file_id}", query_params)
      end

      # Retrieves all documents for the specified file key
      # @param [int] file_id the file key
      # @param [Hash] query_params additional query params to send in the request (optional params: filter)
      # @return [Array] an array of document hashes
      def file_documents(file_id, query_params = nil)
        get("/files/#{file_id}/documents", query_params)
      end

      # Retrieves file_id by specifying a project id and key value
      # @param [int] project_id the project key
      # @param [String] key_value the key value to search on
      # @return [int] the file id
      def file_by_key_value(project_id, key_value)
        get("/files/#{project_id}/ByKeyValue", value: key_value)
      end

      # Updates a file
      # @param [int] file_id the file key
      # @param [Hash] file the file hash with updated fields
      # @return [Hash] the updated file hash
      def file_update(file_id, file)
        post("files/#{file_id}", nil, file)
      end

      # Adds a file
      # @param [Hash] file the file hash to add
      # @return [Hash] the newly added file hash
      def file_add(file)
        put('/files', nil, file)
      end

      # Adds file based on project key value
      # @param [int] project_id the project key value
      # @param [String] key_value the key value
      # @param [Hash] file the file hash with updated fields
      # @return [Hash] the updated file hash
      def file_update_by_key_value(project_id, key_value, file)
        put("/files/#{project_id}/ByKeyValue", { value: key_value }, file)
      end

      # Deletes a file
      # @param [int] file_id the file key
      # @return [bool] true if the file deleted successfully
      def file_delete(file_id)
        delete("/files/#{file_id}")
      end
    end
  end
end
