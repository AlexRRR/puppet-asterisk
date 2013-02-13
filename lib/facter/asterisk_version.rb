require 'puppet'
Facter.add(:asterisk_version) do
  setcode do
    version = Facter::Util::Resolution.exec("asterisk -rx \"core show version\"")
    if version
      version.match(/\d+\.\d+\.\d+/).to_s
    else
      nil
    end
  end
end