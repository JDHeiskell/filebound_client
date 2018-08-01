module FileboundClient
  module Endpoints
    # Module for DocumentBinaryData resource endpoint
    module DocumentBinaryData
      # Retrieves document binary data
      # @param [int] document_id the document key
      # @param [Hash] query_params optional query parameters to pass to the request
      # @return [binary] binary data for the document
      def retrieve_binary_data(document_id, query_params = nil)
        get_binary("/documentBinaryData/#{document_id}", query_params)
      end

      # Adds binary data
      # @param [String] extension the file extension
      # @param [int] file_id the file id to add the binary data to
      # @param [String] binary_data the Base64 encoded binary data to add
      # @return [Hash] the new document
      def add_binary_data(extension, file_id, binary_data)
        raise FileboundClientException.new('extension is required', 0) if extension.blank?
        # rubocop:disable Metrics/LineLength
        raise FileboundClientException.new('file_id is required and must be greater than 0 when adding binary data', 0) if file_id.blank? || file_id.zero?
        # rubocop:enable Metrics/LineLength
        raise FileboundClientException.new('binary_data is required', 0) if binary_data.blank?
        post('/documentBinaryData/0', nil, id: 0, extension: extension, fileId: file_id, documentToUpload: binary_data)
      end

      # Updates binary data
      # @param [int] document_id the document key
      # @param [String] extension the file extension
      # @param [String] binary_data the Base64 encoded binary data to update
      # @return [Hash] the updated document
      def update_binary_data(document_id, extension, binary_data)
        raise FileboundClientException.new('extension is required', 0) if extension.blank?
        raise FileboundClientException.new('binary_data is required', 0) if binary_data.blank?
        post("/documentBinaryData/#{document_id}", nil, id: document_id, extension: extension,
                                                        documentToUpload: binary_data)
      end

      # Adds binary data to the indexing queue
      # @param [String] extension the file extension
      # @param [String] binary_data the Base-64 encoded binary data to send to the indexing queue
      # @param [int] project_id the optional project_id to assign the binary data to
      # @return [Hash] the new document
      def add_to_indexing_queue(extension, binary_data, project_id = nil)
        raise FileboundClientException.new('extension is required', 0) if extension.blank?
        raise FileboundClientException.new('binary_data is required', 0) if binary_data.blank?
        body = { extension: extension, documentToUpload: binary_data }
        body[:projectId] = project_id unless project_id.blank?
        put('/documentBinaryData', nil, body)
      end
    end
  end
end
