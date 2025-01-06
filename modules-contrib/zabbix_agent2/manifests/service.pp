# @summary
#   This class handles the Zabbix Agent 2 service.
#
# @api private
#
class zabbix_agent2::service {

  if $zabbix_agent2::service_manage == true {
    service { 'zabbix_agent2':
      ensure     => $zabbix_agent2::service_ensure,
      enable     => $zabbix_agent2::service_enable,
      name       => $zabbix_agent2::service_name,
      provider   => $zabbix_agent2::service_provider,
      hasstatus  => $zabbix_agent2::service_hasstatus,
      hasrestart => $zabbix_agent2::service_hasrestart,
    }
  }

}
