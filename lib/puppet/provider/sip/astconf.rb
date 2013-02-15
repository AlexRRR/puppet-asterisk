require 'puppet/provider/sip'

Puppet::Type.type(:sip).provide :astconf, :parent=> Puppet::Provider::Sip do
  include Puppet::Util::Sip

  @doc = "Sip provider manages SIP config in from sip.conf file"

  has_feature :astconf
  has_feature :username
  has_feature :secret
  has_feature :context
  has_feature :caller_id

  #confine :exists => :asterisk_version
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


end