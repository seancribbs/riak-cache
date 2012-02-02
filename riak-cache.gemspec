$:.push File.expand_path("../lib", __FILE__)
require 'riak-cache/version'

Gem::Specification.new do |gem|
  # Meta
  gem.name = "riak-cache"
  gem.version = Riak::Cache::VERSION
  gem.summary = %Q{riak-cache is an ActiveSupport::Cache::Store that is backed by Riak.}
  gem.description = %Q{riak-cache is an ActiveSupport::Cache::Store that is backed by Riak. It supports ActiveSupport version 3.x.}
  gem.email = ["sean@basho.com"]
  gem.homepage = "http://github.com/seancribbs/riak-cache"
  gem.authors = ["Sean Cribbs"]

  # Deps
  gem.add_development_dependency "rspec", "~>2.8.0"
  gem.add_development_dependency 'rake'
  gem.add_runtime_dependency "riak-client", "~> 1.0.0.beta"
  gem.add_runtime_dependency "activesupport", "~> 3.0"
  gem.add_runtime_dependency "i18n", ">=0.4.0"

  # Files
  ignores = File.read(".gitignore").split(/\r?\n/).reject{ |f| f =~ /^(#.+|\s*)$/ }.map {|f| Dir[f] }.flatten
  gem.files = (Dir['**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  gem.test_files = (Dir['spec/**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  # gem.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  gem.require_paths = ['lib']
end
