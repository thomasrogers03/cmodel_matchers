source 'https://rubygems.org'

group :development do
  gem 'rdoc'
  gem 'cassandra_model', github: 'thomasrogers03/cassandra_model', require: false
  gem 'rspec', '~> 3.1.0', require: false
  gem 'rspec-its'
end

group :test do
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard'
  gem 'pry'
  gem 'timecop'
  gem 'cassandra_mocks', github: 'thomasrogers03/cassandra_mocks', require: false
end

gemspec
