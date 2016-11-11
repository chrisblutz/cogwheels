Gem::Specification.new do |s|
  s.name        = 'cogwheels'
  s.version     = '0.1.0'
  s.license     = 'MIT'
  s.authors     = ['Christopher Lutz']
  s.email       = ['lutzblox@gmail.com']

  s.files = `git ls-files bin lib LICENSE.txt README.md`.split($RS)
  s.homepage = 'https://github.com/chrisblutz/cogwheels'

  s.add_runtime_dependency 'safe_yaml', '~> 1.0'
end
