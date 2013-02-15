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

  describe 'validate ip' do
    subject { resource }
    a = subject
  specify { subject.validate_ip('192.168.2.200').should == '192.168.2.200'}
    #puts subject
  end

end