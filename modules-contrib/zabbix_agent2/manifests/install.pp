# @summary
#   This class handles Zabbix Agent 2 packages.
#
# @api private
#
class zabbix_agent2::install {


  if ($zabbix_agent2::repo_manage) {

    case $facts['os']['family'] {

      'RedHat' : {

        yumrepo { 'zabbix':
          name     => "Zabbix_${facts['os']['release']['major']}_${facts['os']['architecture']}",
          descr    => "Zabbix_${facts['os']['release']['major']}_${facts['os']['architecture']}",
          baseurl  => "https://repo.zabbix.com/zabbix/${zabbix_agent2::zabbix_version}/rhel/${facts['os']['release']['major']}/\$basearch/",
          gpgcheck => '1',
          gpgkey   => 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
          priority => '1',
        }

        yumrepo { 'zabbix-nonsupported':
          name     => "Zabbix_nonsupported_${facts['os']['release']['major']}_${facts['os']['architecture']}",
          descr    => "Zabbix_nonsupported_${facts['os']['release']['major']}_${facts['os']['architecture']}",
          baseurl  => "https://repo.zabbix.com/non-supported/rhel/${facts['os']['release']['major']}/\$basearch/",
          gpgcheck => '1',
          gpgkey   => 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
          priority => '1',
        }

      }

      'Debian' : {

        include apt

        if ($facts['os']['distro'][id] == 'Raspbian') {
          $operatingsystem = 'raspbian'
        } else {
          $operatingsystem = downcase($facts['os']['name'])
        }

        apt::key { 'zabbix-FBABD5F':
          id     => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
          source => 'https://repo.zabbix.com/zabbix-official-repo.key',
        }
        apt::key { 'zabbix-A1848F5':
          id     => 'A1848F5352D022B9471D83D0082AB56BA14FE591',
          source => 'https://repo.zabbix.com/zabbix-official-repo.key',
        }
        apt::source { 'zabbix':
          location => "http://repo.zabbix.com/zabbix/${zabbix_agent2::zabbix_version}/${operatingsystem}/",
          repos    => 'main',
          release  => $facts['os']['distro']['codename'],
          require  => [
            Apt_key['zabbix-FBABD5F'],
            Apt_key['zabbix-A1848F5'],
          ],
        }

      }

      default  : {
        fail("Managing a repo on ${facts['os']['family']} is currently not implemented")
      }

    }

  }

  if $zabbix_agent2::package_manage {

    package { $zabbix_agent2::package_name:
      ensure => $zabbix_agent2::package_ensure,
    }

  }

}
