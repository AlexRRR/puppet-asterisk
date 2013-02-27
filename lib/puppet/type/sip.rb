$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..",".."))
require 'puppet/util/sip'

Puppet::Type.newtype(:sip) do
  include Puppet::Util::Sip

  @doc = <<-EOS
    This type allow to manage sip peers/users in asterisk from Puppet.
  EOS

  #provider specific features
  feature :astconf, "The provider provides astconf features."

  ensurable do
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.delete
    end
  end


  newparam(:name, :namevar => true) do
    desc "sip peer/user name"
  end

  newparam(:username) do
    desc "If Asterisk is accepting SIP INVITE requests from a remote SIP client, this field specifies the user name for authentication"
  end

  newparam(:secret) do
    desc   "put a strong, unique password here"
  end

  newparam(:context) do
    desc <<-EOS
    If type=user, the Context for the inbound call from this SIP user definition.
    If type=peer, the Context in the dialplan for outbound calls from this SIP peer definition.
    If type=friend the context used for both inbound and outbound calls through the SIP entities definition.
    If no type=user entry matches an inbound call, then a type=peer or type=friend will match if the hostname or IP address defined
    in host= matches.
    EOS
  end

  newproperty(:type) do
    desc <<-EOS
      user|peer|friend : Relationship to client - outbound provider or full client?
    EOS
    newvalues(:friend, :peer, :user)
  end

  newproperty(:permit, :required_features => :astconf) do
    desc <<-EOS
    Allow the sip connection from the following subnet/host
    EOS

    validate do |value|
      @resource.validate_ip(value)
    end
  end

  newproperty(:deny, :required_features => :astconf) do
    desc <<-EOS
    Deny the SIP connection from the following subnet/host
    EOS

    validate do |value|
      @resource.validate_ip(value)
    end
  end

end