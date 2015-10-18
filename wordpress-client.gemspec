$:.push File.expand_path("../lib", __FILE__)
require "wordpress/version"

Gem::Specification.new do |s|
  s.name        = "ct_wordpress-client"
  s.version     = Wordpress::Version
  s.authors     = [" "]
  s.email       = [" "]
  s.homepage    = "https://github.com/coupontom/wordpress-client"
  s.summary     = 'Wordpress API Wrapper.'
  s.description = 'Wordpress API Wrapper.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_runtime_dependency 'faraday', '>= 0.8'
  s.add_runtime_dependency 'logger', '>= 1.2'
  s.add_runtime_dependency 'multi_json', '>= 1.7'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'coveralls'
end
