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

  %w(accountcode allow disallow allowguest amaflags astdb auth callerid busylevel callgroup callingpres canreinvite cid_number context defaultip defaultuser
  directrtpsetup dtmfmode fromuser fromdomain fullcontact fullname host incominglimiti outgoinglimit insecureipaddr language mailbox md5secret musicclass musiconhold
  subscribemwi nat outboundproxy  mask
  pickupgroup port progressinband promiscredir qualify regexten regseconds restrictcid rtpkeepalive rtptimeout rtpholdtimeout secret sendrpid setvar subscribecontext trunkname
  trustrpid useclientcode usereqphone username vmexten).each do |property|
    newproperty(property.to_sym, :required_features => :astconf) do
    end
  end


end