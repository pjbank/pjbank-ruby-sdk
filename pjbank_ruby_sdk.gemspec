# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pjbank_ruby_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "pjbank-ruby-sdk"
  spec.version       = PjbankRubySdk::VERSION
  spec.authors       = ["lmartim"]
  spec.email         = ["l_martim@yahoo.com.br"]

  spec.summary       = %q{Gema do PJBank.}
  spec.description   = %q{Gema do SDK do PJBank.}
  spec.homepage      = "https://github.com/lmartim/pjbank-ruby-sdk"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md pjbank_ruby_sdk.gemspec)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rest-client", "~> 2.0"
end
