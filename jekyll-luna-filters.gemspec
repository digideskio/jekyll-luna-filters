$:.unshift(File.expand_path("../lib", __FILE__))
require "jekyll/luna/filters/version"

Gem::Specification.new do |spec|
  spec.version = Luna::Filters::VERSION
  spec.summary = "A set of filters for Jekyll."
  spec.description = "A set of filters for your Jekyll."
  spec.files = %W(Rakefile Gemfile README.md LICENSE) + Dir["lib/**/*"]
  spec.homepage = "https://github.com/envygeeks/ruby-jekyll-luna-filters"
  spec.email = ["jordon@envygeeks.io"]
  spec.authors = ["Jordon Bedwell"]
  spec.name = "jekyll-luna-filters"
  spec.require_paths = ["lib"]
  spec.license = "MIT"
  spec.has_rdoc = false

  spec.add_runtime_dependency("jekyll", ">= 2.4", "< 3.1")
  spec.add_development_dependency("envygeeks-coveralls", "~> 1.0")
  spec.add_development_dependency("luna-rspec-formatters", "~> 3.3")
  spec.add_development_dependency("rspec", "~> 3.3")
end
