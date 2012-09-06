# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flechtwerk/version'

Gem::Specification.new do |gem|
  gem.name          = "flechtwerk"
  gem.version       = Flechtwerk::VERSION
  gem.authors       = ["Maximilian Schulz"]
  gem.email         = ["m.schulz@kulturfluss.de"]
  gem.description   = %q{A barebone wrapper for the neo4j http api}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/namxam/flechtwerk"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
