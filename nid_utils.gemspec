# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'nid_utils/version'

Gem::Specification.new do |s|
  s.name        = 'nid_utils'
  s.version     = NidUtils::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['TV4']
  s.email       = ['per.astrom@tv4.se']

  s.homepage    = 'https://github.com/TV4/nid_utils'
  s.summary     = %q{Nid utils is used for creating common name for tags}
  s.description = %q{Nid utils is used for creating common name for tags}

  s.files       = Dir.glob("lib/**/*") + %w(Gemfile nid_utils.gemspec README.markdown)
  s.test_files  = Dir.glob('spec/*')

  s.add_runtime_dependency 'activesupport', '~> 3.0'
  s.add_runtime_dependency 'i18n'
  s.add_development_dependency 'rspec', '~> 2.7.0'
  s.add_development_dependency 'ci_reporter', '1.6.5'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
end
