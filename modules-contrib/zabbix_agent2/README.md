# zabbix_agent2

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Credits](#credits)

## Description

This module installs and configures Zabbix Agent 2

[Zabbix Agent 2][0] is a new generation of Zabbix agent and may be used in place of Zabbix agent.

## Usage

Example configuration:

```puppet
class {'::zabbix_agent2':
  config => {
    PidFile       => '/run/zabbix/zabbix_agent2.pid',
    LogFile       => '/var/log/zabbix/zabbix_agent2.log',
    LogFileSize   => 0,
    Server        => '10.10.10.10',
    ServerActive  => '10.10.10.10',
    Hostname      => $::fqdn,
    Include       => '/etc/zabbix/zabbix_agent2.d/*.conf',
    ControlSocket => '/tmp/agent.sock',
  }
}
```

...or the same config in Hiera:

```yaml
zabbix_agent2::config:
  PidFile: '/run/zabbix/zabbix_agent2.pid'
  LogFile: '/var/log/zabbix/zabbix_agent2.log'
  LogFileSize: 0
  Server: '10.10.10.10'
  ServerActive: '10.10.10.10'
  Hostname: "%{::fqdn}"
  Include: '/etc/zabbix/zabbix_agent2.d/*.conf'
  ControlSocket: '/tmp/agent.sock'

```

Will be represented in zabbix_agent2.conf like this:

```
PidFile=/run/zabbix/zabbix_agent2.pid
LogFile=/var/log/zabbix/zabbix_agent2.log
LogFileSize=0
Server=10.10.10.10
ServerActive=10.10.10.10
Hostname=server.domain.com
Include=/etc/zabbix/zabbix_agent2.d/*.conf
ControlSocket=/tmp/agent.sock
```

## Limitations

This module only handles the Zabbix Agent 2 package, config and service.
All other special requirements (such as modules, custom monitoring scripts etc.) are outside the scope.

### Tested on

* CentOS 8
* Ubuntu 20.04

## Credits

* Most of the puppet code is based on [puppetlabs-ntp][1] by Puppet

[0]: https://www.zabbix.com/documentation/current/manual/concepts/agent2
[1]: https://github.com/puppetlabs/puppetlabs-ntp
