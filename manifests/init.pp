class debian_updater {

  File {
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/debian_updater/':
    ensure => 'directory',
  }

  file { '/etc/debian_updater/debian_updates':
    ensure  => 'file',
    mode    => '0644',
    source  => file('debian_updater/debian_updates'),
    require => File['/etc/debian-updater/'],
  }

  file { '/usr/local/sbin/package-installed':
    ensure => 'file',
    source => file('debian_updater/package-installed'),
  }

  exec { "apt-get update && apt-get install --yes $( cat /etc/debian_updater/debian_updates | /usr/local/sbin/package-installed )":
    require     => File['/usr/local/sbin/package-installed'],
    subscribe   => File['/etc/debian-updater/debian-updates'],
    refreshonly => true
  }

}
