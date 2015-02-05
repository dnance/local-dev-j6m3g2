
exec {'system-update':
  path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ], 
  command=>'sudo apt-get update',
 }

class add-python-properties {
  package { "python-software-properties":
  ensure  => installed,
  provider=>apt,
  require=>Exec['system-update'],
}
  }


exec { 'git-repository-update':
path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ], 
command=>'sudo add-apt-repository ppa:git-core/ppa',
require=>Class["add-python-properties"],
}

exec { 'git-system-update':
path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ], 
command =>'sudo apt-get update',
require=>Exec["git-repository-update"],
}

class open-jdk {
package {'openjdk-6-jdk':
ensure=> installed,
require=>Exec['system-update'],
}
}

class git {
package {'git':
ensure=>installed,
require=>Exec['system-update'],
}
}

class maven {
package {'maven':
ensure=>installed,
require=>Class['open-jdk'],
}
}



include add-python-properties
include open-jdk
include git
include maven
