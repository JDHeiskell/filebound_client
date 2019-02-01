require 'ext/object'
require 'ext/hash'
require 'filebound_client/version'
require 'filebound_client/configuration'
require 'filebound_client/config'
require 'filebound_client/connection'
require 'filebound_client/endpoints'

# This is the core module
module FileboundClient
  # This encapsulates all client/server communications
  class Client
    include FileboundClient::Endpoints

    # General client exception class
    class FileboundClientException < StandardError
      attr_reader :result
      def initialize(message, result)
        super(message)
        @result = result
      end
    end

    # Creates, initialize and logs into the Filebound API
    # @param [Hash] config a hash of configuration values
    # @return [FileboundClient::Client] an instance of FileboundClient::Client
    def self.connect(config)
      connection = FileboundClient::Connection.build_connection(config)
      raise FileboundClientException.new('Failed to login', 401) unless connection.login
      new(connection)
    end

    # Initializes the client with the supplied Connection
    # @param [Connection] connection the logged in Connection
    # @return [FileboundClient::Client] an instance of FileboundClient::Client
    def initialize(connection)
      @connection = connection
    end

    # Executes a GET request on the current Filebound client session expecting JSON in the body of the response
    # @param [String] url the resource url to request
    # @param [Hash] query_params the optional query parameters to pass to the GET request
    # @return [Hash] the JSON parsed hash of the response body
    def get(url, query_params = nil)
      JSON.parse(perform('get', url, query: query_params), symbolize_names: true)
    end

    # Executes a GET request on the current Filebound client session expecting binary in the body of the response
    # @param [String] url the resource url to request
    # @param [Hash] query_params the optional query parameters to pass to the GET request
    # @return [String] Base64 encoded binary string
    def get_binary(url, query_params = nil)
      perform('get', url, query: query_params)
    end

    # Executes a PUT request on the current Filebound client session expecting JSON in the body of the request/response
    # @param [String] url the resource url to request
    # @param [Hash] query_params the optional query parameters to pass to the PUT request
    # @param [Hash] body the hash that will be converted to JSON when inserted in the body of the request
    # @return [Hash] the JSON parsed hash of the response body
    def put(url, query_params = nil, body = nil)
      params = { headers: { 'Content-Type' => 'application/json' }, query: query_params, body: body }
      JSON.parse(perform('put', url, params), symbolize_names: true)
    end

    # Executes a POST request on the current Filebound client session expecting JSON in the body of the request/response
    # @param [String] url the resource url to request
    # @param [Hash] query_params the optional query parameters to pass to the POST request
    # @param [Hash] body the hash that will be converted to JSON when inserted in the body of the request
    # @return [Hash] the JSON parsed hash of the response body
    def post(url, query_params = nil, body = nil)
      params = { headers: { 'Content-Type' => 'application/json' }, query: query_params, body: body }
      JSON.parse(perform('post', url, params), symbolize_names: true)
    end

    # Executes a DELETE request on the current Filebound client session
    # @param [String] url the resource url to request
    # @param [Hash] query_params the optional query parameters to pass to the DELETE request
    # @return [true, false] true if resource was deleted successfully
    def delete(url, query_params = nil)
      perform('delete', url, query: query_params)
      true
    end

    # The connection representing the currently logged on session with the Filebound API
    # @return [FileboundClient::Connection] the security token used in all requests made to the Filebound server
    attr_reader :connection

    private_class_method :new

    private

    def perform(action, url, params)
      response = connection.send(action, url, params)
      if response.error?
        message = <<~ERROR
          #{action.upcase} request failed: #{response.code}
          Headers: #{response.headers}
          Body: #{response.body}
        ERROR
        raise FileboundClientException.new(message, response.code)
      end

      response.body
    end
  end
end
