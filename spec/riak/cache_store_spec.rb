require 'spec_helper'
require 'riak/cache_store'

describe Riak::CacheStore do
  let(:web_port){ test_server.http_port }
  subject { ActiveSupport::Cache.lookup_store(:riak_store, :http_port => web_port) }

  describe "Riak integration" do
    it "should have a client" do
      subject.should respond_to(:client)
      subject.client.should be_kind_of(Riak::Client)
    end

    it "should have a bucket to store entries in" do
      subject.bucket.should be_kind_of(Riak::Bucket)
    end

    it "should configure the client according to the initialized options" do
      subject = ActiveSupport::Cache.lookup_store(:riak_store, :http_port => 10000)
      subject.client.nodes.all? { |n| n.http_port == 10000 }.should == true
    end

    it "should choose the bucket according to the initializer option" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :bucket => "foobar", :http_port => web_port)
      cache.bucket.name.should == "foobar"
    end

    it "should set the N value to 2 by default" do
      subject.bucket.n_value.should == 2
    end

    it "should set the N value to the specified value" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :n_value => 1, :http_port => web_port)
      cache.bucket.n_value.should == 1
    end

    it "should set the bucket R value to 1 by default" do
      subject.bucket.r.should == 1
    end

    it "should set the bucket R default to the specified value" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :r => "quorum", :http_port => web_port)
      cache.bucket.r.should == "quorum"
    end

    it "should set the bucket W value to 1 by default" do
      subject.bucket.w.should == 1
    end

    it "should set the bucket W default to the specified value" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :w => "all", :http_port => web_port)
      cache.bucket.w.should == "all"
    end

    it "should set the bucket DW value to 0 by default" do
      subject.bucket.dw.should == 0
    end

    it "should set the bucket DW default to the specified value" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :dw => "quorum", :http_port => web_port)
      cache.bucket.dw.should == "quorum"
    end

    it "should set the bucket RW value to quorum by default" do
      subject.bucket.rw.should == "quorum"
    end

    it "should set the bucket RW default to the specified value" do
      cache = ActiveSupport::Cache.lookup_store(:riak_store, :rw => "all", :http_port => web_port)
      cache.bucket.rw.should == "all"
    end
  end


  it "should read and write strings" do
    subject.write('foo', 'bar')
    subject.read('foo').should == 'bar'
  end

  it "should read and write hashes" do
    subject.write('foo', {:a => "b"})
    subject.read('foo').should == {:a => "b"}
  end

  it "should read and write integers" do
    subject.write('foo', 1)
    subject.read('foo').should == 1
  end

  it "should read and write nil" do
    subject.write('foo', nil)
    subject.read('foo').should be_nil
  end

  it "should return the stored value when fetching on hit" do
    subject.write('foo', 'bar')
    subject.fetch('foo'){'baz'}.should == 'bar'
  end

  it "should return the default value when fetching on miss" do
    subject.fetch('does-not-exist'){ 'baz' }.should == 'baz'
  end

  it "should return the default value when forcing a miss" do
    subject.fetch('foo', :force => true){'bar'}.should == 'bar'
  end

  it "should detect if a value exists in the cache" do
    subject.write('foo', 'bar')
    subject.exist?('foo').should be_true
  end

  it "should delete matching keys from the cache" do
    subject.write('foo', 'bar')
    subject.write('green', 'thumb')
    subject.delete_matched(/foo/)
    subject.read('foo').should be_nil
    subject.read('green').should == 'thumb'
  end

  it "should delete a single key from the cache" do
    subject.write('foo', 'bar')
    subject.read('foo').should == 'bar'
    subject.delete('foo')
    subject.read('foo').should be_nil
  end
end
