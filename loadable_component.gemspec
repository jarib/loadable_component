# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "loadable_component/version"

Gem::Specification.new do |s|
  s.name        = "loadable_component"
  s.version     = LoadableComponent::VERSION
  s.authors     = ["Jari Bakken"]
  s.email       = ["jari.bakken@gmail.com"]
  s.homepage    = "http://github.com/jarib/loadable_component"
  s.summary     = %q{Ruby implementation of http://code.google.com/p/selenium/wiki/LoadableComponent}
  s.description = %q{Ruby implementation of http://code.google.com/p/selenium/wiki/LoadableComponent}

  s.rubyforge_project = "loadable_component"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
