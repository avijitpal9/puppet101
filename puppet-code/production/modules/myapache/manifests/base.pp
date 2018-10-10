class myapache::base {

  if $facts[os][family] == 'RedHat' {
    $pkg_name = 'httpd'
    $svc_name = 'httpd'

  } elsif $facts[os][family] == 'Debian' {
    $pkg_name = 'apache2'
    $svc_name = 'apache2'
  }

  package { 'apache':
    name => $pkg_name,
    ensure => present,
  }

  service { 'apache':
    name => $svc_name,
    ensure => running,
    require => Package['apache'],
  }
}
