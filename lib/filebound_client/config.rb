module FileboundClient
  # Config module
  module Config
    # Retrive the current configuration
    # @return [FileboundClient::Configuration]
    def configuration
      @configuration
    end

    # Creates a new Configuration object and yields to the caller
    def configure
      @configuration ||= Configuration.new
      yield @configuration
    end
  end
end
