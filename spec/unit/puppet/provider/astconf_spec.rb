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
