source :rubygems

gemspec
gem 'bundler'

if File.directory?(File.expand_path("../../riak-client", __FILE__))
  gem 'riak-client', :path => "../riak-client"
end

group :guard do
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'growl'
end
