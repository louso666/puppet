# @summary Base zabbix_agent2 class
#
# Installs and configures Zabbix Agent 2
#
# @example Declaring the class
#   include ::zabbix_agent2
#
# @param config Hash containing entire Zabbix Agent 2 config.
#
# @param config_file
#   Specifies a file for Zabbix Agent 2's configuration info. Default value: '/etc/zabbix/zabbix_agent2.conf'.
#
# @param config_file_ensure Whether the Zabbix Agent 2 config file should be present or absent. Default value: present.
#
# @param config_file_mode
#   Specifies a file mode for the Zabbix Agent 2 configuration file. Default value: '0644'.
#
# @param config_epp
#   Specifies an absolute or relative file path to an EPP template for the config file.
#   Example value: 'zabbix_agent2/zabbix_agent2.conf.epp'. A validation error is thrown if both this **and** the `config_template` parameter are specified.
#
# @param config_template
#   Specifies an absolute or relative file path to an ERB template for the config file.
#   Example value: 'zabbix_agent2/zabbix_agent2.conf.erb'. A validation error is thrown if both this **and** the `config_epp` parameter are specified.
#
# @param package_ensure
#   Whether to install the Zabbix Agent 2 package, and what version to install. Values: 'present', 'latest', or a specific version number.
#   Default value: 'present'.
#
# @param package_manage
#   Whether to manage the Zabbix Agent 2 package. Default value: true.
#
# @param package_name
#   Specifies the Zabbix Agent 2 package to manage. Default value: ['zabbix-agent2']
#
# @param repo_manage
#   Whether to manage the Zabbix repo. Default value: true.
#
# @param service_enable
#   Whether to enable the Zabbix Agent 2 service at boot. Default value: true.
#
# @param service_ensure
#   Whether the Zabbix Agent 2 service should be running. Default value: 'running'.
#
# @param service_manage
#   Whether to manage the Zabbix Agent 2 service.  Default value: true.
#
# @param service_name
#   The Zabbix Agent 2 service to manage. Default value: 'zabbix-agent2'
#
# @param service_provider
#   Which service provider to use for Zabbix Agent 2. Default value: 'undef'.
#
# @param service_hasstatus
#   Whether service has a functional status command. Default value: true.
#
# @param service_hasrestart
#   Whether service has a restart command. Default value: true.
#
# @param zabbix_version
#   The Zabbix version to install. Default value: '5.0'.
#
class zabbix_agent2 (
  Hash $config,
  Stdlib::Absolutepath $config_file,
  String $config_file_ensure,
  String $config_file_mode,
  Optional[String] $config_epp,
  Optional[String] $config_template,
  String $package_ensure,
  Boolean $package_manage,
  Array[String] $package_name,
  Boolean $repo_manage,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $service_hasstatus,
  Boolean $service_hasrestart,
  String[1] $zabbix_version
) {

  contain zabbix_agent2::install
  contain zabbix_agent2::config
  contain zabbix_agent2::service

  Class['::zabbix_agent2::install']
  -> Class['::zabbix_agent2::config']
  ~> Class['::zabbix_agent2::service']

}
