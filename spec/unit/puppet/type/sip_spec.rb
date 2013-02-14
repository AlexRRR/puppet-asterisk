#!/usr/bin/env rspec

require 'spec_helper'

sip = Puppet::Type.type(:sip)

describe sip do
  before :each do
    @class = sip
    @provider = stub 'sip'
    @provider.stubs(:name).returns(:sip)
    Puppet::Type::Sip.stubs(:defaultprovider).returns @provider

    @resource = @class.new({:name => 'foo'})

    Facter.fact(:asterisk_version).stubs(:value).returns("1.8.10")

  end

  it 'should have :name as namevar' do
    @class.key_attributes.should == [:name]
  end

  describe ':type' do
    [:friend, :user, :peer].each do |stype|
      it "should accept SIP type #{stype}" do
        @resource[:type] = stype
        @resource[:type].should == stype
      end
    end
  end



end




