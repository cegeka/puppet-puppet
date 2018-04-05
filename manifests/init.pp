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
  $package_name     = 'puppet',
  $package_version  = 'present',
  $puppet_config    = '/etc/puppet/puppet.conf'
) {

  file { $puppet_config :
    ensure => present,
    owner  => 'puppet',
    group  => 'puppet',
    notify => Service['puppet'],
  }

  package { $package_name :
    ensure => $package_version
  }

  service { 'puppet':
    ensure     => $service_ensure,
    enable     => $service_enabled,
    hasrestart => true,
    hasstatus  => true;
  }

}
