$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'cogwheels/version'

Gem::Specification.new do |s|
  s.name        = 'cogwheels'
  s.version     = Cogwheels::VERSION
  s.license     = 'MIT'
  s.authors     = ['Christopher Lutz']
  s.email       = ['lutzblox@gmail.com']

  s.required_ruby_version = '>= 2.0'

  s.files = `git ls-files bin lib LICENSE.txt README.md`.split($RS)

  s.summary = 'A lightweight Ruby configuration-loading library'
  s.description = <<-HEREDOC
Cogwheels is a lightweight library to load configurations from YAML files into easy-to-use hash-like objects
  HEREDOC
  s.homepage = 'https://github.com/chrisblutz/cogwheels'

  s.add_runtime_dependency 'safe_yaml', '~> 1.0'
end
