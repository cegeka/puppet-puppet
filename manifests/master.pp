# Class: puppet::master
#
# This module manages puppet master
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master (
  $service_ensure   = 'running',
  $service_enabled  = true,
  $package_name     = 'puppetserver',
  $package_version  = 'present'
) {

  package { $package_name :
    ensure => $package_version
  }

  service { $package_name :
    ensure     => $service_ensure,
    enable     => $service_enabled,
    hasrestart => true,
    hasstatus  => true;
  }

}
