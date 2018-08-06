lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filebound_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'filebound_client'
  spec.version       = FileboundClient::VERSION
  spec.authors       = ['Bryan Richardson']
  spec.email         = ['brichardson@heiskell.com']

  spec.summary       = 'Provides connection to FileBound API'
  spec.homepage      = 'https://github.com/JDHeiskell/filebound_client'
  spec.license       = 'MIT'

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

  spec.add_runtime_dependency 'httpi', '~> 2.4.0'
  spec.add_runtime_dependency 'rubyntlm', '~> 0.6.0'
end
