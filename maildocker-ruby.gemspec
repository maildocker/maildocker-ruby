lib = File.expand_path('../maildocker', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maildocker/version'

Gem::Specification.new do |spec|
  spec.name        = 'maildocker-ruby'
  spec.version     = '1.0'
  spec.summary     = 'Maildocker Gem'
  spec.description = 'Interact with Maildocker API in Ruby'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['maildocker']

  spec.add_dependency 'rest-client'
  spec.add_dependency 'mime-types'
  spec.add_development_dependency 'bundler', '~> 1.6'
end
