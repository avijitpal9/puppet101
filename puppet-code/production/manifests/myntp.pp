# myntp.pp
class myntp {

  package { 'ntp':
   ensure => 'present',
  }

  service { 'ntpd':
    ensure => running,
    enable => true,
    require => Package['ntp'], ## require is a metaparameters
  }

}
