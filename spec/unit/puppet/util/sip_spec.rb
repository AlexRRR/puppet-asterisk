require 'spec_helper'


describe 'Puppet::Util::Sip' do
  let(:resource) {
    type = Puppet::Type.type(:sip)
    provider = stub 'provider'
    provider.stubs(:name).returns(:astconf)
    Puppet::Type::Sip.stubs(:defaultprovider).returns(provider)
    type.new({:name => 'foo'})
  }

  before(:each) {resource}

  describe 'valid ip should can be used' do
    subject { resource }
    specify { subject.validate_ip('192.168.2.200').should == '192.168.2.200'}
    specify { subject.validate_ip('192.168.2.200/24').should == '192.168.2.0'}
    specify { subject.validate_ip('0.0.0.0').should == '0.0.0.0'}
  end

  describe 'invalid ip should be rejected' do
    subject { resource }
    it "should reject invalid IP address" do
      expect  { subject.validate_ip('foobar')}.to raise_error(ArgumentError, "invalid IP address")
    end
  end





end