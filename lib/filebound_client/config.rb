module FileboundClient
  # Config module
  module Config
    # Retrive the current configuration
    # @return [FileboundClient::Configuration]
    def configuration
      @configuration
    end

    # Retrieve the default logger
    # @return [Logger] the default logger
    def default_logger
      logger ||= Logger.new(STDOUT)
      logger.level = Logger::DEBUG
      logger
    end

    # Creates a new Configuration object and yields to the caller
    # Also sets the logger
    def configure
      @configuration ||= Configuration.new
      yield @configuration

      @configuration.logger ||= default_logger
    end

    # Simple logger plugin for debugging
    def logger(message)
      return unless configuration.logger
      configuration.logger.debug(message)
    end
  end
end
