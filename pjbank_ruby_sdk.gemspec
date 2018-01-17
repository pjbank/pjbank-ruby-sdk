# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pjbank/version"

Gem::Specification.new do |spec|
  spec.name          = "pjbank"
  spec.version       = PJBank::VERSION
  spec.authors       = ["lmartim", "Hugo Maia Vieira"]
  spec.email         = ["l_martim@yahoo.com.br", "hugomaiavieira@gmail.com"]

  spec.summary       = %q{Gema do PJBank.}
  spec.description   = %q{Gema do SDK do PJBank.}
  spec.homepage      = "https://github.com/pjbank/pjbank-ruby-sdk"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md pjbank_ruby_sdk.gemspec)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry-byebug', '~> 3.5'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'webmock', '~> 3.2'
  spec.add_development_dependency 'vcr', '~> 4.0'

  spec.add_runtime_dependency "rest-client", "~> 2.0"
end
