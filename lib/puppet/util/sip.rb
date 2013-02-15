require 'ipaddr'

module Puppet::Util::Sip

  def validate_ip(ipaddress)
      if (ip = IPAddr.new(ipaddress))
        return ip.to_string
      end
    rescue
      raise ArgumentError.new("invalid IP address")
      return nil
    end
  end
