#
#
define puppet::master5::setting(
  $ensure = present,
  $value = undef,
  $config = '/etc/puppetlabs/puppetserver/config.d/webserver.conf',
  $context = 'webserver'
) {

  Augeas {
    lens    => 'Trapperkeeper.lns',
    incl    => $config,
    context => "/files${config}/@hash[.='${context}']"
  }

  case $ensure {
    absent: {
      augeas { "puppet::master5::${title}":
        onlyif  => "match ${title} size > 0",
        changes => "rm ${title}",
      }
    }
    present: {
      if ($value != undef) {
        if is_bool($value) {
          $real_value = bool2str($value)
          } else {
            $real_value = $value
        }
        augeas { "puppet::master5::${title}":
          #onlyif  => "match ${title}[. = '${real_value}'] size == 0",
          onlyif  => "match @simple[.='${title}']/@value[.='${real_value}'] size == 0",
          changes => [
            "set @simple[.='${title}'] ${title}",
            "set @simple[.='${title}']/@value '${real_value}'"
          ],
        }
      } else {
        fail("Puppet::Master5::Setting[${title}]: required parameter value ${value} must be a non-empty string")
      }
    }
    default: {
      fail("Puppet::Master5::Setting[${title}]: parameter ensure must be present or absent")
    }
  }

}
