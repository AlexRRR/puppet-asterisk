#!/usr/bin/env rspec

require 'spec_helper'
require 'puppet'
require 'puppet/provider/confine/exists'
require 'puppet/type/sip'
require 'inifile'

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
                                         :name  => 'foo',
                                         :username => 'bar',
                                         :secret  => 'dark',
                                     })
  }

  before :each do
    provider.stubs(:config_file).returns("spec/fixtures/simple.conf")
  end

  it 'should be able to get a list of existing SIP extensions' do
    provider.instances.each do |extension|
      puts extension
      extension.should be_an_instance_of(provider)
    end
  end

  #it 'should be verify the existance of resource' do
  #  resource.provider.exists?().should be_true
  #end

  it 'should be able to create an inifile object from a resource' do
    ini = IniFile.load("spec/fixtures/simple.conf")
    a = resource.provider.resource_to_ini
    a.instance_variable_get(:@ini).should == ini.instance_variable_get(:@ini)
  end


end

describe 'sip creation' do
  let(:provider) { Puppet::Type.type(:sip).provider(:astconf) }
  let(:resource) {
    Puppet::Type.type(:sip).new({
                                    :name  => 'foo',
                                    :username => 'bar',
                                    :secret  => 'dark',
                                    :ensure => 'present'
                                })
  }

  let(:resource_two) {
    Puppet::Type.type(:sip).new({
                                    :name  => 'honey',
                                    :username => 'bear',
                                    :secret  => 'now',
                                    :ensure => 'present'
                                })
  }

  let (:instance) {
    provider.new(resource)
  }
  let (:instance_two) {
    provider.new(resource_two)
  }
  let (:test_file) {
    "spec/fixtures/write-simple.conf"
  }

  before :each do
    provider.stubs(:config_file).returns(test_file)
  end

  it 'should create a new file if it does not exist' do
    File.exists?(test_file) ? File.delete(test_file) : puts("nope")
    instance.flush
    File.exists?(test_file).should be_true
  end

  it 'should merge resource into existing config file' do
    instance_two.flush
    sip_config = IniFile.load(test_file)
    (sip_config.has_section?(resource[:name]) && sip_config.has_section?(resource_two[:name])).should be_true
    File.delete(test_file)
  end

end
