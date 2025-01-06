# @summary
#   This class handles the configuration file.
#
# @api private
#
class zabbix_agent2::config {

  #If both epp and erb are defined, throw validation error.
  #Otherwise use the defined erb/epp template, or use default
  if $zabbix_agent2::config_epp and $zabbix_agent2::config_template {
    fail('Cannot supply both config_epp and config_template templates for zabbix_agent2 config file.')
  } elsif $zabbix_agent2::config_template {
    $config_content = template($zabbix_agent2::config_template)
  } elsif $zabbix_agent2::config_epp {
    $config_content = epp($zabbix_agent2::config_epp)
  } else {
    $config_content = epp('zabbix_agent2/zabbix_agent2.conf.epp')
  }

  file { $zabbix_agent2::config_file:
    ensure  => $::zabbix_agent2::config_file_ensure,
    owner   => 0,
    group   => 0,
    mode    => $::zabbix_agent2::config_file_mode,
    content => $config_content,
  }

}
