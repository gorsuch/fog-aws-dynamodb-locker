# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/aws/dynamodb/locker'

Gem::Specification.new do |gem|
  gem.name          = "fog-aws-dynamodb-locker"
  gem.version       = Fog::AWS::DynamoDB::Locker::VERSION
  gem.authors       = ["Michael Gorsuch"]
  gem.email         = ["michael.gorsuch@gmail.com"]
  gem.description   = %q{an attempt to leverage DynamoDB as an HA lock store}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/gorsuch/fog-aws-dynamodb-locker"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('fog')
  gem.add_development_dependency('rspec')
end
