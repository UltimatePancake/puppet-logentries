# puppet-logentries
Logentries.com log monitoring installation and configuration module.

## Usage

```ruby
  class { '::logentries::install':
    license_key => 'YOUR-LICENSE-KEY',
    before      => Class['::logentries::follow'],
  }

  class { '::logentries::follow':
    log_files => {
      'nginx_error'  => { 'path' => '/var/log/nginx/error.log' },
      'some_log'     => { 'path' => '/path/to/your/log' },
    },
  }
```
