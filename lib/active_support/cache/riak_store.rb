require 'riak-cache'
ActiveSupport::Cache::RiakStore = Riak::CacheStore unless defined?(ActiveSupport::Cache::RiakStore)
