default['devops_vault']['root'] = 'secret/dev/'
default['devops_vault']['url'] = 'https://cbutoolsvault.ci.dimensiondata.cloud:8200'
default['devops_vault']['secret_databag'] = 'devops_vault'
default['devops_vault']['secret_databag_item'] = 'token'
default['devops_vault']['fabio_cert_path'] = 'certificates/star_ci_dimensiondata_cloud'

default['didata-fabio']['init_style']   = 'runit'
default['didata-fabio']['open_files']   = 65535
default['didata-fabio']['config']       = {
	 'registry.consul.tagprefix'=>"url_#{node.chef_environment}-",
    'proxy.responseheadertimeout'=>'15s',
    'proxy.keepalivetimeout'=>'15s',
    'proxy.dialtimeout'=>'2m'
}
default['didata-fabio']['install_path'] = '/usr/local/bin/fabio'



default['didata-fabio']['conf_dir']     = '/etc/fabio'
default['didata-fabio']['log_dir']      = '/var/log/fabio'
default['didata-fabio']['service_name'] = 'fabio'
default['didata-fabio']['port'] = 443



# Installation source
default['didata-fabio']['release_url']  = 'https://github.com/fabiolb/fabio/releases/download/v1.5.2/fabio-1.5.2-go1.8.3-linux_amd64'
default['didata-fabio']['checksum']     = '62c192a306f754b8279bf21808f725a6bae6b9de2caa59af06b62542f5e718b2'

default['didata-fabio']['tls']['enabled']=false
default['didata-fabio']['tls']['ssl_cert']['path'] = '/etc/pki/tls/certs/fabio.pem'
default['didata-fabio']['tls']['ssl_cert']['source'] = 'file'
default['didata-fabio']['tls']['ssl_key']['path'] = '/etc/pki/tls/private/fabio.key'
default['didata-fabio']['tls']['ssl_key']['source'] = 'file'