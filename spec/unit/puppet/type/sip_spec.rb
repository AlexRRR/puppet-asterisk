#!/usr/bin/env rspec

require 'spec_helper'
require 'puppet'
sip = Puppet::Type.type(:sip)

describe sip do
  before :each do
    @class = sip
    @provider = stub 'astconf'
    @provider.stubs(:name).returns(:astconf)
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

  [:permit,:deny].each do |rule|
    describe "#{rule}" do
        it "should allow valid ipv4 addresses" do
          @resource[rule] = "192.168.200.2/32"
          @resource[rule].should == "192.168.200.2/32"
        end

        it "should deny invalid ipv4 addresses" do
          lambda {@resource[rule] = '192.300.200.1'}.should raise_error(Puppet::Error)
        end
    end
  end




end




