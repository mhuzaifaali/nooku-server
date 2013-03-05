define nginx::resource::vhost (
  $www_root = undef,
) {
  include nginx::params

  $require = Class['nginx::service']

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "${nginx::params::conf_dir}/sites-available/${$name}.conf":
    ensure  => 'file',
    content => template('nginx/vhost.conf.erb'),
    notify  => Class['nginx::service'],
  }

  file { "${nginx::params::conf_dir}/sites-enabled/${$name}.conf":
     ensure  => 'link',
     target  => "${nginx::params::conf_dir}/sites-available/${$name}.conf",
     require => File["${nginx::params::conf_dir}/sites-available/${$name}.conf"],
  }
}