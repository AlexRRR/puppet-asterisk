

Puppet::Type.newtype(:sip) do

  @doc = <<-EOS
    This type allow to manage sip peers/users in asterisk from Puppet.
  EOS

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




end