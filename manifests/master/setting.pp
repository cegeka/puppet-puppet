# Define: puppet master
#
define puppet::master::setting( $ensure = 'present', $value = undef, $config = '/etc/puppet/puppet.conf' ) {

  Augeas {
    lens    => 'Puppet.lns',
    incl    => $config,
    context => "/files${config}/master",
  }

  case $ensure {
    'absent': {
      augeas { "puppet::master::${title}":
        onlyif  => "match ${title} size > 0",
        changes => "rm ${title}",
      }
    }
    'present': {
      if ($value == undef) or ((! is_string($value)) and (! is_bool($value))) {
        fail("Puppet::Master::Setting[${title}]: required parameter value must be a non-empty string")
      }
      else {
        if is_bool($value) {
          $real_value = bool2str($value)
        } else {
          $real_value = $value
        }
        augeas { "puppet::master::${title}":
          onlyif  => "match ${title}[. = '${real_value}'] size == 0",
          changes => "set ${title} '${real_value}'",
        }
      }
    }
    default: {
      fail("Puppet::Master::Setting[${title}]: parameter ensure must be present or absent")
    }
  }

}
