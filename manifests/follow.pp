# Class: logentries::follow
#
#   This class adds a log file to the Logentries.com follow list
#
# Parameters:
#
#   [*$log_files*] - List of log paths to be monitored.
#
# Examples:
#
#   class { 'logentries::follow':
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
class logentries::follow (
  $log_files = [],
) {
  if $log_files[0] == undef {
    fail('Please specify at least one log file to monitor.')
  } else {
    each($log_files) |$log| {
      exec { "follow_${log}":
        command => "/usr/bin/le follow '${log}'",
        notify  => Service['logentries'],
      }
    }
  }

  service { 'logentries':
    ensure      => running,
    enable      => true,
    refreshonly => true,
  }
}
