$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..",".."))
require 'puppet/util/sip'

Puppet::Type.newtype(:sip) do
  include Puppet::Util::Sip

  @doc = <<-EOS
    This type allow to manage sip peers/users in asterisk from Puppet.
  EOS

  feature :username, " If Asterisk is accepting SIP INVITE requests from a remote SIP client, this field specifies the user name for authentication"
  feature :secret, "put a strong, unique password here instead"
  feature :context, <<-EOS
    If type=user, the Context for the inbound call from this SIP user definition.
    If type=peer, the Context in the dialplan for outbound calls from this SIP peer definition.
    If type=friend the context used for both inbound and outbound calls through the SIP entities definition.
    If no type=user entry matches an inbound call, then a type=peer or type=friend will match if the hostname or IP address defined
    in host= matches.
  EOS
  feature :callerid, "callerid"
  #provider specific features
  feature :astconf, "The provider provides astconf features."

  ensurable

  newparam(:name) do
    desc "sip peer/user name"
  end

  newproperty(:type) do
    desc <<-EOS
      user|peer|friend : Relationship to client - outbound provider or full client?
    EOS
    newvalues(:friend, :peer, :user)
  end

  newproperty(:permit, :required_features => :astconf) do
    desc <<-EOS
    IP address and network restriction
    EOS
  end












end