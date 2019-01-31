module FileboundClient
  module Endpoints
    # Module for Documents resource endpoint
    module Documents
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :document
          allow_all :documents
        end
      end

      # Retrieves a single document
      # @param [int] document_id the document key
      # @return [Hash] the document hash
      def document(document_id, query_params = nil)
        get("/documents/#{document_id}", query_params)
      end

      # Returns the eform data for the document key
      # @param [int] document_id the document key
      # @param [Hash] query_params the additional query params to send in the request
      # @return [Hash] the EFormData hash
      def document_eform_data(document_id, query_params = nil)
        get("/documents/#{document_id}/eformdata", query_params)
      end

      # Returns the eform detail for the document key
      # @param [int] document_id the document key
      # @param [Hash] query_params the additional query params to send in the request
      # @return [Hash] the EFormDetail hash
      def document_eform_detail(document_id, query_params = nil)
        get("/documents/#{document_id}/eformdetail", query_params)
      end

      # Returns a rendition for the document key
      # @param [int] document_id the document key
      # @param [Hash] query_params the additional query params to send in the request (optional: page(int))
      # @return [String] rendition for the document
      def document_rendition(document_id, query_params = nil)
        get("/documents/#{document_id}/rendition", query_params)
      end

      # Adds eform data to document
      # @param [int] document_id the document key
      # @param [Hash] eform_data the eform data hash to add
      # @return [Hash] the newly added eform data hash
      def document_add_eformdata(document_id, eform_data)
        put("/documents/#{document_id}/eformdata", nil, eform_data)
      end

      # Adds eform detail to document
      # @param [int] document_id the document key
      # @param [Hash] eform_detail the eform detail to add
      # @return [Hash] the newly added eform detail hash
      def document_add_eformdetail(document_id, eform_detail)
        put("/documents/#{document_id}/eformdetail", nil, eform_detail)
      end

      # Updates eform data for the document
      # @param [int] document_id the document key
      # @param [Hash] eform_data the eform data hash to update
      # @param [Hash] query_params additional query parameters to pass to the request (optional: deleteNonMatches(bool))
      # @return [Hash] the updated eform data hash
      def document_update_eformdata(document_id, eform_data, query_params = nil)
        post("/documents/#{document_id}/eformdata", query_params, eform_data)
      end

      # Updates eform detail for the document
      # @param [int] document_id the document key
      # @param [Hash] eform_detail the eform detail hash to update
      # @param [Hash] query_params additional query parameters to pass to the request (optional: deleteNonMatches(bool))
      # @return [Hash] the updated eform detail hash
      def document_update_eformdetail(document_id, eform_detail, query_params = nil)
        put("/documents/#{document_id}/eformdetail", query_params, eform_detail)
      end

      # Updates a document
      # @param [Hash] document the document hash to update
      # @param [Hash] query_params additional query parameters to pass to the request (optional: setBinaryData(bool))
      # @return [int] the document id that was updated
      def document_update(document, query_params = nil)
        post("/documents/#{document[:id]}", query_params, document)
      end

      # Adds a document
      # @param [Hash] document the document hash to add
      # @return [Hash] the newly added document hash
      def document_add(document)
        raise FileboundClientException.new('File Id is required', 0) unless document && document[:fileId].positive?
        put("/documents/#{document[:fileId]}", nil, document)
      end

      # Delete a document
      # @param [int] document_id the document key
      # @return [bool] true if document was deleted successfully
      def document_delete(document_id)
        delete("/documents/#{document_id}")
      end
    end
  end
end
