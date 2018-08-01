lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filebound_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'filebound_client'
  spec.version       = FileboundClient::VERSION
  spec.authors       = ['Bryan Richardson']
  spec.email         = ['brichardson@heiskell.com']

  spec.summary       = '%q{Provides connection to FileBound API}'
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # rubocop:disable Style/GuardClause
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end
  # rubocop:enable Style/GuardClause

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16.0'
  spec.add_development_dependency 'rake', '~> 12.3.0'
  spec.add_development_dependency 'yard', '~> 0.9.0'

  spec.add_runtime_dependency 'ruby-ntlm', '~> 0.0.4'
end
