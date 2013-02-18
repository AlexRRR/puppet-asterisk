require 'puppet/provider/sip'
require 'facter'
require 'inifile'



Puppet::Type.type(:sip).provide :astconf, :parent=> Puppet::Provider::Sip do
  include Puppet::Util::Sip

  @doc = "Sip provider manages SIP config in from sip.conf file"

  has_feature :astconf
  has_feature :username
  has_feature :secret
  has_feature :context
  has_feature :caller_id

  confine :true => true




  def insert
    debug 'Inserting rule %s' % resource[:name]
  end

  def update
    debug 'Updating rule %s' % resource[:name]
  end

  def delete
    debug 'Deleting rule %s' % resource[:name]
  end

  def exists?
    properties[:ensure] != :absent
  end

  def self.instances
    debug "[instances]"
    puts Dir.pwd
    extensions = []
    sip_conf = IniFile.new(:filename => 'spec/fixtures/simple.conf')
    sip_conf.each_section do |sip|
      extensions << new(:name => sip, :secret => 'dark')
    end
    return extensions



  end

end