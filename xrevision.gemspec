# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xrevision/version'

Gem::Specification.new do |gem|
  gem.name          = "xrevision"
  gem.version       = Xrevision::VERSION
  gem.authors       = ["Michal Wrobel"]
  gem.email         = ["sparrovv@gmail.com"]
  gem.description   = %q{Rack middleware that puts revision id into response headers}
  gem.summary       = %q{Rack middleware that puts revision id into response headers }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('rack')
  gem.add_development_dependency('rspec')
end
