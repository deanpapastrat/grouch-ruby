# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grouch/version'

Gem::Specification.new do |spec|
  spec.name          = "grouch"
  spec.platform      = Gem::Platform::RUBY
  spec.version       = Grouch::VERSION
  spec.authors       = ["Dean Papastrat"]
  spec.email         = ["dean.g.papastrat@gmail.com"]

  spec.summary       = %q{A Ruby implementation of Grouch, OSCAR scraper and API}
  spec.description   = %q{Grouch is a tool to gather data from the Georgia Tech's OSCAR Course registration tool and parse it into an easy machine readable format. It makes an attempt to be lightweight and extensible. It is not in any way approved by Georgia Tech. It was originally written in Python - this is a Ruby port.}
  spec.homepage      = "https://github.com/deanpapastrat/grouch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
