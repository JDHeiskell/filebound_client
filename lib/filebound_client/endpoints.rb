Dir[File.join(__dir__, '/endpoints/*.rb')].each { |file| require file }

module FileboundClient
  # Module for resource endpoints
  module Endpoints
    # Sets up macros for use by endpoints and includes all endpoints
    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def self.included(klass)
      klass.instance_eval do
        # @!macro [attach] fb.allow_new
        # Returns a new empty resource with defaulted values
        # @return [Hash] a new hash of $1
        def self.allow_new(name)
          define_method("#{name}_new") do
            get('/empty', template: name.to_s)
          end
        end

        # @!macro [attach] fb.allow_all
        # Returns an array $1 hashes
        # @param [Hash] query_params params to pass to the request
        # @return [Array] an array of $1 hashes
        def self.allow_all(name)
          define_method(name.to_s) do |query_params = nil|
            get("/#{name}", query_params)
          end
        end
      end

      klass.class_eval do
        include FileboundClient::Endpoints::Projects
        include FileboundClient::Endpoints::Files
        include FileboundClient::Endpoints::Documents
        include FileboundClient::Endpoints::Version
        include FileboundClient::Endpoints::Assignments
        include FileboundClient::Endpoints::Dividers
        include FileboundClient::Endpoints::DocumentBinaryData
        include FileboundClient::Endpoints::EFormData
        include FileboundClient::Endpoints::EFormDetail
        include FileboundClient::Endpoints::Separators
        include FileboundClient::Endpoints::Query
        include FileboundClient::Endpoints::Users
        include FileboundClient::Endpoints::Routes
        include FileboundClient::Endpoints::RoutedItems
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
