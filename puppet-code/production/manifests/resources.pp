# resources.pp

user { 'avijit':
  ensure => present,
  uid => 1001,
}

file { '/tmp/myfile.txt':
  ensure => present,
  owner => 'root',
  mode => '644',
  content => 'This File is Managed by Puppet',
}
