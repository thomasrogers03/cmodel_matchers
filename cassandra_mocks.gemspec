Gem::Specification.new do |s|
  s.name = 'cmodel_matchers'
  s.version = '0.0.1'
  s.license = 'Apache License 2.0'
  s.summary = 'RSpec testing helpers for Cassandra Model'
  s.description = %q{}
  s.authors = ['Thomas RM Rogers']
  s.email = 'thomasrogers03@gmail.com'
  s.files = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE.txt', '*.md']
  s.require_path = 'lib'
  s.homepage = 'https://www.github.com/thomasrogers03/cmodel_matchers'
  s.add_runtime_dependency 'cassandra_model', '~> 0.9.19'
  s.add_runtime_dependency 'activesupport', '~> 4.0'
  s.add_runtime_dependency 'rspec', '~> 3.1.0'
  s.add_runtime_dependency 'rspec-its', '~> 1.2.0'
end
