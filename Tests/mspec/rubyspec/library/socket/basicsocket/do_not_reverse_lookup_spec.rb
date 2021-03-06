require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/../fixtures/classes'

ruby_version_is ""..."1.9" do
  describe "BasicSocket.do_not_reverse_lookup" do
    before(:each) do
      @server = TCPServer.new('127.0.0.1', SocketSpecs.port)
      @socket = TCPSocket.new('127.0.0.1', SocketSpecs.port)
    end
    
    after(:each) do
      @socket.close unless @socket.closed?
      @server.close unless @server.closed?
    end

    it "causes 'peeraddr' to avoid name lookups" do
      BasicSocket.do_not_reverse_lookup = true
      @socket.peeraddr.should == ["AF_INET", SocketSpecs.port, "127.0.0.1", "127.0.0.1"]
    end

    it "looks for hostnames when set to false" do
      BasicSocket.do_not_reverse_lookup = false
      @socket.peeraddr[2].should == SocketSpecs.hostname
    end

    it "looks for numeric addresses when set to true" do
      BasicSocket.do_not_reverse_lookup = true
      @socket.peeraddr[2].should == "127.0.0.1"
    end
  end
end

ruby_version_is "1.9" do
  describe "BasicSocket.do_not_reverse_lookup" do
    before(:each) do
      @server = TCPServer.new('127.0.0.1', SocketSpecs.port)
      @socket = TCPSocket.new('127.0.0.1', SocketSpecs.port)
    end
    
    after(:each) do
      @server.close unless @server.closed?
      @socket.close unless @socket.closed?
    end

    it "causes 'peeraddr' to avoid name lookups" do
      @socket.do_not_reverse_lookup = true
      @socket.peeraddr.should == ["AF_INET", SocketSpecs.port, "127.0.0.1", "127.0.0.1"]
    end

    it "looks for hostnames when set to false" do
      @socket.do_not_reverse_lookup = false
      @socket.peeraddr[2].should == SocketSpecs.hostname
    end

    it "looks for numeric addresses when set to true" do
      @socket.do_not_reverse_lookup = true
      @socket.peeraddr[2].should == "127.0.0.1"
    end
  end
end
