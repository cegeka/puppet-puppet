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
  $service_enabled  = true
) {

  file { '/etc/puppet/puppet.conf':
    ensure => present,
    owner  => 'puppet',
    group  => 'puppet',
    notify => Service['puppet'],
  }

  service { 'puppet':
    ensure     => $service_ensure,
    enable     => $service_enabled,
    hasrestart => true,
    hasstatus  => true;
  }

}
