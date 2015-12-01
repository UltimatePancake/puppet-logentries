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
class logentries {}
