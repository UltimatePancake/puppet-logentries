# Class: logentries
#
#   This class installs and configures the Logentries.com agent to the
#   target node.
#
# Parameters:
#
#   [*license_key*] - Your Logentries.com license key.
#
#   [*use_latest*]  - Whether or not the package manager should download the
#                     latest or only present package.
#
#   [*$log_files*]  - List of log paths to be monitored.
#
# Examples:
#
#   class { 'logentries':
#     license_key => 'YOUR-LICENSE-KEY',
#     log_files = [
#       "/var/log/nginx/access.log",
#       "/var/log/*.log",
#     ],
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
class logentries (
  $license_key = undef,
  $use_latest  = true,
  $log_files   = [],
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

  if $log_files.empty? {
    fail('Please specify at least one log file to monitor.')
  }

  class { '::install':
    license_key => $license_key,
    use_latest  => $use_latest,
  }

  class { '::follow':
    log_files => $log_files,
  }
}
