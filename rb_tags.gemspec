# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rb_tags/version'

Gem::Specification.new do |spec|
  spec.name          = 'rb_tags'
  spec.version       = RbTags::VERSION
  spec.authors       = ['LeFnord']
  spec.email         = ['pscholz.le@gmail.com']

  spec.summary       = 'A wrapper around ctags.'
  spec.description   = 'A wrapper around ctags, with search for tag and open file if found.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'

  spec.add_runtime_dependency 'awesome_print'
  spec.add_runtime_dependency 'bundler'
  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'rake'
  spec.add_runtime_dependency 'parslet'
  spec.add_runtime_dependency 'parallel'
  spec.add_runtime_dependency 'gli'
end
