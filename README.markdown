# Rails/ActiveSupport Cache Store for Riak (riak-cache) [![Build Status](https://secure.travis-ci.org/seancribbs/riak-cache.png)](http://travis-ci.org/seancribbs/riak-cache)

`riak-cache` is an implementation of `ActiveSupport::Cache::Store`
that stores cached values in Riak. This is especially useful if you
have configured Riak to use an in-memory backend.

## Dependencies

`riak-cache` requires ActiveSupport version 3.x for its parent class,
and `riak-client` to connect to Riak.

Development dependencies are handled with bundler. Install bundler
(`gem install bundler`) and run this command:

``` bash
$ bundle install
```

To pin to a specific version of ActiveSupport (rather than the latest
3.x version), specify the `BUNDLE_GEMFILE` environment variable:

``` bash
$ BUNDLE_GEMFILE=Gemfile.rails31 bundle install
```

## Configuring and Using

To use `riak-cache` with your Rails project, include it in your
project's `Gemfile` and set it as the cache store inside your
`config/application.rb` like so:

``` ruby
config.cache_store = :riak_store
```

To provide extra configuration (for example, which Riak nodes to
connect to), use an array:

```ruby
config.cache_store = [:riak_store, {:http_port => 10000}]
```

Otherwise, you can simply instantiate and use the class wherever you
like:

```ruby
cache = Riak::CacheStore.new
cache.fetch('pages/1234') { render_page }
```

## License & Copyright

Copyright &copy;2010-2012 Sean Cribbs and Basho Technologies, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
