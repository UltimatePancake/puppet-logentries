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
# Authors:
#
#   Pier-Angelo Gaetani
#
# Copyright:
#
#   Pier-Angelo Gaetani 2015
#
class logentries::follow (
  $log_files,
) {
  define log_follow ($path) {
    exec { $name:
      command => "/usr/bin/le follow ${path} --name ${name}",
      notify  => Service['logentries'],
    }
  }

  if $log_files == undef {
    fail('Please specify at least one log file to monitor.')
  } else {
    create_resources(log_follow, $log_files)
  }

  service { 'logentries':
    ensure => running,
    enable => true,
  }
}
