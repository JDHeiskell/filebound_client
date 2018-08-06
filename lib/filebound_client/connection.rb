require 'filebound_client/config'
require 'json'
require 'httpi'

module FileboundClient
  # Encapsulates low level logic to talk to Filebound server
  class Connection
    include Config

    # The token returned from the Filebound server on successfully logging in
    # @return [Guid] the security token used in all requests made to the Filebound server
    attr_reader :token

    # Creates a new connection using the supplied configuration
    # @param [Configuration] config the Configuration to use for the connection
    # @return [Connection] the newly created and initialized Connection
    def self.build_connection(config)
      new(config)
    end

    # Initialize a new connection with the supplied configuration
    # @param [Configuration] config the Configuration to use for the connection
    # @return [Connection] the newly created and initialized Connection
    def initialize(config)
      configure do |c|
        c.host = config[:host]
        c.api_base_uri = config[:api_base_uri]
        c.username = config[:username]
        c.password = config[:password]
        # rubocop:disable Metrics/LineLength
        c.ntlm_auth = { user: config[:ntlm_user], password: config[:ntlm_password], domain: config[:ntlm_domain] } if config[:use_ntlm]
        # rubocop:enable Metrics/LineLength
        HTTPI.adapter = :net_http
      end
    end

    private_class_method :new

    # The Filebound server hostname and protocol
    # @return [String] the Filebound server URL
    # @example
    #    "http://localhost"
    def host
      configuration.host
    end

    # The base path to the API on the Filebound server
    # @return [String] the base path to the API
    # @example
    #   "/api"
    def api_base_uri
      configuration.api_base_uri
    end

    # The username to log on to the Filebound server with
    # @return [String] the username
    # @example
    #   "username"
    def username
      configuration.username
    end

    # The password to log on to the Filebound server with
    # @return [String] the password
    # @example
    #   "password"
    def password
      configuration.password
    end

    # The NTLM username to use for NTLM Authentication
    # @return [String] the NTLM username
    # @example
    #   "ntlm_user"
    def ntlm_user
      configuration.ntlm_auth[:user] if configuration.ntlm_auth
    end

    # The NTLM password to use for NTLM Authentication
    # @return [String] the NTLM password
    # @example
    #   "ntlm_password"
    def ntlm_password
      configuration.ntlm_auth[:password] if configuration.ntlm_auth
    end

    # The NTLM domain to use for NTLM Authentication
    # @return [String] the NTLM domain
    # @example
    #   "ntlm_domain"
    def ntlm_domain
      configuration.ntlm_auth[:domain] if configuration.ntlm_auth
    end

    # The authentication query parameters required by all requests to the API
    # @return [Hash] the query parameters hash
    def auth_params
      { query: { guid: token } }
    end

    # Sends a GET request to the supplied resource using the supplied params hash
    # @param [String] url the url that represents the resource
    # @param [Hash] params the params Hash that will be sent in the request (keys: query, headers, body)
    # @return [Net::HTTPResponse] the response from the GET request
    def get(url, params)
      request = HTTPI::Request.new(resource_url(url, query_params(params[:query])))
      execute_request(:get, request, params)
    end

    # Sends a PUT request to the supplied resource using the supplied params hash
    # @param [String] url the url that represents the resource
    # @param [Hash] params the params Hash that will be sent in the request (keys: query, headers, body)
    # @return [Net::HTTPResponse] the response from the PUT request
    def put(url, params)
      request = HTTPI::Request.new(resource_url(url, query_params(params[:query])))
      request.body = params[:body].to_json
      execute_request(:put, request, params)
    end

    # Sends a POST request to the supplied resource using the supplied params hash
    # @param [String] url the url that represents the resource
    # @param [Hash] params the params Hash that will be sent in the request (keys: query, headers, body)
    # @return [Net::HTTPResponse] the response from the POST request
    def post(url, params)
      request = HTTPI::Request.new(resource_url(url, query_params(params[:query])))
      request.body = params[:body].to_json
      execute_request(:post, request, params)
    end

    # Sends a DELETE request to the supplied resource using the supplied params hash
    # @param [String] url the url that represents the resource
    # @param [Hash] params the params Hash that will be sent in the request (keys: query, headers, body)
    # @return [Net::HTTPResponse] the response from the DELETE request
    def delete(url, params)
      request = HTTPI::Request.new(resource_url(url, query_params(params[:query])))
      execute_request(:delete, request, params)
    end

    # Sends a POST request to the Filebound API's login endpoint to request a new security token
    # @return [true, false] returns true if the login was successful and the token was set
    def login
      response = post('/login', body: { username: configuration.username, password: configuration.password },
                                headers: { 'Content-Type' => 'application/json' })
      if response.code == 200
        @token = JSON.parse(response.body, symbolize_names: true)
        true
      else
        false
      end
    end

    private

    def resource_url(url, query)
      return "http://#{host}#{api_base_uri}/#{url.reverse.chomp('/').reverse}" unless query
      query_string = query.map { |k, v| "#{k}=#{v}" }.join('&')
      "http://#{host}#{api_base_uri}/#{url.reverse.chomp('/').reverse}?#{query_string}"
    end

    def query_params(params)
      if params
        auth_params[:query].merge!(params)
      else
        auth_params[:query]
      end
    end

    def set_headers(request, headers)
      if headers.respond_to?(:to_hash)
        headers.each do |k, v|
          request.headers[k.to_s] = v.to_s
        end
      end
      request
    end

    def execute_request(method, request, params)
      request = set_headers(request, params[:headers])
      request.auth.ntlm(ntlm_user, ntlm_password, ntlm_domain) if configuration.ntlm_auth
      HTTPI.request(method, request)
    end
  end
end
