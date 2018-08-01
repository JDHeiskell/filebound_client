require 'bundler/setup'
require 'filebound_client'
require 'yaml'
require 'ntlm/http'
require 'base64'

Dir[File.join(__dir__, 'factories', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  Factories.constants.each { |constant| config.include Object.const_get("Factories::#{constant}") }
end
