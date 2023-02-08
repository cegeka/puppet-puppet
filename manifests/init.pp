# Class: puppet
#
# This module manages puppet
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet (
  $service_ensure   = 'running',
  $service_enabled  = true,
  $package_ensure   = 'latest',
  $package_name     = 'puppet',
  $puppet_config_ensure = 'present',
  $puppet_config    = '/etc/puppet/puppet.conf'
) {

  file { $puppet_config :
    ensure => $puppet_config_ensure,
    owner  => 'puppet',
    group  => 'puppet',
    notify => Service['puppet'],
  }

  package { $package_name :
    ensure => $package_ensure
  }

  service { 'puppet':
    ensure     => $service_ensure,
    enable     => $service_enabled,
    hasrestart => true,
    hasstatus  => true;
  }

}
