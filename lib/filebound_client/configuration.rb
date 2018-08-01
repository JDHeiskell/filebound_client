module FileboundClient
  # Encapsulate configuration data
  class Configuration
    attr_accessor :host, :api_base_uri, :username, :password, :logger, :ntlm_auth
  end
end
