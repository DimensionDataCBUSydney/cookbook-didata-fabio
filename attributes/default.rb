default['didata-fabio']['init_style']   = 'runit'
default['didata-fabio']['open_files']   = 65535
default['didata-fabio']['config']       = {}
default['didata-fabio']['install_path'] = '/usr/local/bin/fabio'



default['didata-fabio']['conf_dir']     = '/etc/fabio'
default['didata-fabio']['log_dir']      = '/var/log/fabio'
default['didata-fabio']['service_name'] = 'fabio'
default['didata-fabio']['port'] = 443


# Installation source
default['didata-fabio']['release_url']  = 'https://github.com/eBay/fabio/releases/download/v1.3.8/fabio-1.3.8-go1.7.5-linux_amd64'
default['didata-fabio']['checksum']     = '259506179b6e0a255510a5a82436729ff8ff477ca859244d3fa22fecd51e38f8'

default['didata-fabio']['tls']['enabled']=false
