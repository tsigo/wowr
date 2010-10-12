# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wowr/version"

Gem::Specification.new do |s|
  s.name        = "wowr"
  s.version     = Wowr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Humphreys", "Peter Wood", "Renaud Chaput"]
  s.email       = ["peter+wowr@alastria.net"]
  s.homepage    = "http://wowr.rubyforge.org/"
  s.summary     = %q{A Ruby library for the World of Warcraft Armory}
  s.description = %q{Wowr is a Ruby library for accessing data in the World of Warcraft Armory. It provides an object-oriented interface to the XML data provided by the armory, giving access to items, characters, guilds and arena teams. It is designed for both single users and larger guild or portal sites for many users.}

  s.rubyforge_project = "wowr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rcov"

  s.add_dependency "hpricot", "= 0.8.2"
  s.add_dependency "json", "= 1.4.3"
end
