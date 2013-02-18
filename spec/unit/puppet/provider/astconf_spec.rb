#!/usr/bin/env rspec

require 'spec_helper'
require 'puppet'
require 'puppet/provider/confine/exists'
require 'puppet/type/sip'

describe 'sip provider suitability' do
  let(:exists) {
    Puppet::Provider::Confine::Exists
  }

  before :each do
    Puppet::Type.type(:sip).defaultprovider = nil
    Facter.clear
    Facter.fact(:asterisk_version).stubs(:value).returns("1.8.10")
  end

  it "should default to sip if asterisk version is found" do
    resource = Puppet::Type.type(:sip).new({:name => 'foo'})
    resource.provider.class.to_s.should == "Puppet::Type::Sip::ProviderAstconf"
  end

end
describe 'sip provider' do
  let(:provider) { Puppet::Type.type(:sip).provider(:astconf) }
  let(:resource) {
    Puppet::Type.type(:sip).new({
                                         :name  => 'foobar',
                                         :secret  => 'dark',
                                     })
  }



  it 'should be able to get a list of existing SIP extensions' do
    provider.instances.each do |extension|
      puts extension
      extension.should be_an_instance_of(provider)
      #extension.properties[:provider].to_s.should == provider.name.to_s
    end
  end



end
