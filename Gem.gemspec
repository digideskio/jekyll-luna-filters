$:.unshift(File.expand_path("../lib", __FILE__))
require "luna/filters/version"

Gem::Specification.new do |spec|
  spec.files = %W(Readme.md License) + Dir["lib/**/*"]
  spec.homepage = "http://github.com/envygeeks/jekyll-luna-filters/"
  spec.description = "A set of filters for Jekyll."
  spec.summary = "A set of filters for Jekyll."
  spec.version = Luna::Filters::VERSION
  spec.email = ["envygeeks@gmail.com"]
  spec.name = "jekyll-luna-filters"
  spec.license = "Apache 2.0"
  spec.has_rdoc = false
  spec.require_paths = ["lib"]
  spec.authors = ["Jordon Bedwell"]
  spec.add_runtime_dependency("jekyll", ">= 1.4")
end
