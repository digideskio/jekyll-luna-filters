$:.unshift(File.expand_path("../lib", __FILE__))
require "luna/filters/version"

Gem::Specification.new do |spec|
  spec.files = %W(README.md LICENSE) + Dir["lib/**/*"]
  spec.homepage = "http://github.com/envygeeks/jekyll-luna-filters/"
  spec.description = "A set of filters for your Jekyll."
  spec.summary = "A set of filters for Jekyll."
  spec.version = Luna::Filters::VERSION
  spec.email = ["jordon@envygeeks.io"]
  spec.name = "jekyll-luna-filters"
  spec.license = "Apache 2.0"
  spec.has_rdoc = false
  spec.require_paths = ["lib"]
  spec.authors = ["Jordon Bedwell"]
  spec.add_runtime_dependency("jekyll", ">= 2.4", "< 3.1")
end
