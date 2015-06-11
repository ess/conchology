# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conchology/version'

Gem::Specification.new do |spec|
  spec.name          = "conchology"
  spec.version       = Conchology::VERSION
  spec.authors       = ["Dennis Walters"]
  spec.email         = ["pooster@gmail.com"]

  spec.summary       = %q{A gem that knows about calling out to the shell}
  spec.description   = <<-DESCRIPTION
  Conchology provides a friendly wrapper for Open4 to run one-off commands
  while providing information about the run of said commands.
  DESCRIPTION
  spec.homepage      = "https://github.com/ess/conchology"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 1.9")
  spec.add_development_dependency("rake", "~> 10.0")
  spec.add_development_dependency("rspec", "~> 3.2")
  spec.add_dependency('open4', '~> 1.3')
end
