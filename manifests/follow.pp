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
#   class { '::logentries::follow':
#     log_files => {
#       'nginx_error'  => { 'path' => '/var/log/nginx/error.log' },
#       'some_log'     => { 'path' => '/path/to/your/log' },
#     },
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
  $log_files,
) {
  define log_follow ($path) {
    exec { $name:
      command => "le follow \"${path}\" --name ${name}",
      path    => '/usr/bin/:/bin/',
      unless  => "le followed \"${path}\"",
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
