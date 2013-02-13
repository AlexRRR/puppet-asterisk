require 'spec_helper'
require 'puppet'

describe "Facter::Util::Fact" do
  before {
    Facter.clear
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter.fact(:kernelrelease).stubs(:value).returns("2.6")
  }

  describe 'asterisk_version' do
    it {
      astversion = "Asterisk 1.8.10.1~dfsg-1ubuntu1 built by buildd @ yellow on a x86_64 running Linux on 2012-04-24 12:47:04 UTC"
      Facter::Util::Resolution.stubs(:exec).with("asterisk -rx \"core show version\"").returns(astversion)
      Facter.fact(:asterisk_version).value.should == '1.8.10'
    }
  end


end