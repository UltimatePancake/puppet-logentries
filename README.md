# puppet-newrelic
Logentries.com log monitoring installation and configuration module.

## Usage

```ruby
  class { 'logentries':
    license_key => 'YOUR-LICENSE-KEY',
    log_files = [
      "/var/log/nginx/access.log",
      "/var/log/*.log",
    ],
  }
```
