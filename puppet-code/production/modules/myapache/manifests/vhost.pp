class myapache::vhost {

  file { '/var/www/mysite.internal':
    ensure => directory,
    owner => 'apache',
    group => 'apache',
    require => Package['apache'],
  }

  file { '/var/www/mysite.internal/index.html':
    ensure => present,
    content => "you are visiting mysite internal domain !!",
    owner => 'apache',
    group => 'apache',
    require => File['/var/www/mysite.internal']

  }

  file { '/etc/httpd/conf.d/vhost.conf':
    ensure => present,
    source => 'puppet:///modules/myapache/vhost.conf',
    notify => Service['apache'],
    require => File['/var/www/mysite.internal/index.html'],
  }

}
