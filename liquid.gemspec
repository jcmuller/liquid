# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "liquid"
  s.version     = "2.5.0"
  s.platform    = Gem::Platform::RUBY
  s.summary     = "A secure, non-evaling end user template engine with aesthetic markup."
  s.authors     = ["Tobias Luetke"]
  s.email       = ["tobi@leetsoft.com"]
  s.homepage    = "http://www.liquidmarkup.org"
  #s.description = "A secure, non-evaling end user template engine with aesthetic markup."

  s.required_rubygems_version = ">= 1.3.7"

  s.test_files  = Dir.glob("{test}/**/*")
  s.files       = Dir.glob("{lib}/**/*") +
                  Dir.glob("{ext}/**/*") + %w(MIT-LICENSE README.md)

  s.extensions = ['ext/liquid/extconf.rb']

  s.extra_rdoc_files  = ["History.md", "README.md"]

  s.require_paths = ["lib", "ext"]
end
