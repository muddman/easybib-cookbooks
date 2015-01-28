default['haproxy']             = {}
default['haproxy']['errorloc'] = {
  '400' => '400.http',
  '403' => '403.http',
  '408' => '408.http',
  '500' => '5xx.http',
  '502' => '5xx.http',
  '503' => '5xx.http',
  '504' => '5xx.http'
}

default['haproxy']['type'] = '1.4' # 1.4 or 1.5
default['haproxy']['ssl'] = 'off' # off, on, only - on/only works only with 1.5
default['haproxy']['ctl'] = {}
default['haproxy']['ctl']['version'] = '1.1.0'
default['haproxy']['ctl']['base_path'] = '/usr/local/share'
default['haproxy']['log_dir'] = '/mnt/var/log/haproxy'
default['haproxy']['ssl_params']['ciphers'] = 'DEFAULT:!AES128:!CAMELLIA128:!RC4:!MEDIUM:!LOW:!EXP!3DES:@STRENGTH'
default['haproxy']['ssl_params']['default_bind_options'] = 'no-sslv3'
default['haproxy']['hsts'] = nil
