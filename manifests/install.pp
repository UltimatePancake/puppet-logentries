# Class: logentries::install
#
#   This class installs the Logentries.com agent to the target node.
#
# Parameters:
#
#   [*license_key*] - Your Logentries.com license key.
#
#   [*use_latest*]  - Whether or not the package manager should download the
#                     latest or only present package.
#
# Examples:
#
#   class { 'logentries::install':
#     license_key => 'YOUR-LICENSE-KEY',
#   }
#
# Authors:
#
#   Pier-Angelo Gaetani
#
# Copyright:
#
#   Pier-Angelo Gaetani 2015
#
class logentries::install (
  $license_key = undef,
  $use_latest  = true,
) {
  if $license_key == undef {
    fail('The license_key parameter must be defined.')
  }

  if $use_latest == true {
    $package_ensure = 'latest'
  } elsif $use_latest == false {
    $package_ensure = 'present'
  } else {
    fail('The use_latest parameter must be true or false.')
  }

  apt::source { 'logentries':
    location    => 'http://rep.logentries.com/',
    repos       => 'main',
    key         => 'C43C79AD',
    key_server  => 'keyserver.ubuntu.com',
    include_src => false,
    include_deb => true,
    before      => Package['logentries'],
  }

  package { 'logentries':
    ensure => $package_ensure,
  }

  $cmd_register = "/usr/bin/le register --account-key=${license_key}"

  exec { 'register_logentries_agent':
    command => $cmd_register,
    require => Package['logentries'],
    before  => Package['logentries-agent'],
  }

  package { 'logentries-agent':
    ensure  => $package_ensure,
  }
}
