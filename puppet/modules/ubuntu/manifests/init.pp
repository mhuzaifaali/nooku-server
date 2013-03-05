class ubuntu {
  exec { 'ignore-grub':
    command   => 'apt-mark hold grub-common grub-pc grub-pc-bin grub2-common',
    logoutput => 'on_failure',
  }

  exec { 'ubuntu-update':
    command   => 'apt-get -q -y update',
    logoutput => 'on_failure',
  }

  exec { 'ubuntu-upgrade':
    command   => 'apt-get -q -y upgrade',
    logoutput => 'on_failure',
    require   => [ Exec['ignore-grub'], Exec['ubuntu-update'] ],
  }
}