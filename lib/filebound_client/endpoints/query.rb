module FileboundClient
  module Endpoints
    # Module for Query resource endpoint
    module Query
      # Runs a query against the API using the project, files and documents query supplied.
      # See https://applications.filebound.com/v3/documentation/endpoints#Custom+Query for more detail.
      # @param [String] projects_query the comma-delimited projects query, pass 'all' for no filter (ex: name_Invoices)
      # @param [String] files_query the comma-delimited files query, pass 'all' for no filter (ex: status_1)
      # @param [String] documents_query the comma-delimited documents query, pass 'all' for no filter (ex: divider_HR)
      # @example Get project named Invoices with Files that have a status of 1 and documents with a divider named HR
      #   query('name_Invoices','status_1','divider_HR')
      def query(projects_query, files_query, documents_query, query_params = nil)
        get("/query/#{projects_query}/#{files_query}/#{documents_query}", query_params)
      end
    end
  end
end
