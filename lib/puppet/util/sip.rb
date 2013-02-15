require 'ipaddr'

module Puppet::Util::Sip

  def validate_ip(ipaddress)
      if (ip = IPAddr.new(ipaddress))
        return ip.to_string
      end
    rescue
      puts 'Invalid IP Address'
      return nil
    end
  end
