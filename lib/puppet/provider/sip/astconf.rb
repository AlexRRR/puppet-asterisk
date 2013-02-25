require 'puppet/provider/sip'
require 'facter'
require 'inifile'



Puppet::Type.type(:sip).provide :astconf, :parent=> Puppet::Provider::Sip do
  include Puppet::Util::Sip

  @doc = "Sip provider manages SIP config in from sip.conf file"
  has_feature :astconf
  confine :true => true

  def create
    debug 'Creating extension %s' % resource[:name]
    ini = resource_to_ini
    sip_conf = IniFile.load(self.class.config_file)
    if sip_conf.nil?
      ini.write(:filename => self.class.config_file)
    else
      sip_conf.merge(ini)
      sip_conf.write(:filename => self.class.config_file)
    end
  end

  def update
    debug 'Updating rule %s' % resource[:name]
    pre =  IniFile.load(self.class.config_file)
    ini = resource_to_ini
    final = pre.merge(ini)
    final.write(:filename => self.class.config_file)
  end

  def delete
    debug 'Deleting rule %s' % resource[:name]
    pre =  IniFile.load(self.class.config_file)
    pre.delete_section(resource[:name])
    pre.write(:filename => self.class.config_file)
  end

  def flush
    @property_hash.clear
  end

  def exists?
    properties[:ensure] == :present

    #sip_conf = IniFile.load(self.class.config_file)
    #unless sip_conf.nil?
    #  return sip_conf.has_section?(resource[:name])
    #end
    #return false
  end

  def self.instances
    debug "[instances]"
    extensions =  []
    a = config_file
    sip_conf = IniFile.new(:filename => a)
    arg_config = Hash.new()
    sip_conf.each_section do |section|
      arg_config[:name] = section
      sip_conf[section].each do |key,value|
        arg_config[key.to_sym] = value
      end
      extensions << new(arg_config)
    end
    return extensions
  end

  #need to create this accessor method to be able to mock it and test easier. must find a better way.
  def self.config_file
    return '/etc/asterisk/sip.conf'
  end

  def resource_to_ini
    entry = IniFile.new
    tmp = resource.original_parameters.clone
    #inifile returns keys as strings not symbols, we should do the same.
    tmp.keys.each do |key|
      tmp[(key.to_s rescue key) || key] = tmp.delete(key)
    end
    entry[resource[:name]] = tmp
    entry
  end




end