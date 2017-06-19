# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_blockchain/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_blockchain"
  spec.version       = SimpleBlockchain::VERSION
  spec.authors       = ["Mariano Schmidt"]
  spec.email         = ["marianogabriels@gmail.com"]

  spec.summary       = %q{simple experimental blockchain}
  spec.description   = %q{simple experimental blockchain}
  spec.homepage      = "https://github.com/marianogabriels/simple_blockchain"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  #spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #  f.match(%r{^(test|spec|features)/})
  #end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "msgpack"
  spec.add_dependency "thin"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "eventmachine"
  spec.add_development_dependency "rspec", "~> 3.0"
end
