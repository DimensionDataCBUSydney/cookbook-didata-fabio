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
default['didata-fabio']['artifactory']['secret_databag'] = 'artifactory_secrets'
default['didata-fabio']['artifactory']['secret_databag_item'] = 'api_key'
default['didata-fabio']['artifactory']['url'] = 'https://artifactory.devops.itaas-cloud.com'
default['didata-fabio']['artifactory']['certificate-repo']='certificate-repo-local'
default['didata-fabio']['didata_ca_certificate']['cer_file']='Didata_Clould_Root_CA.cer'
default['didata-fabio']['didata_intermediate_certificate']['cer_file']='Didata_Clould_Int_CA.cer'
default['didata-fabio']['ssl_certificate']['pfx_file']='star_ci_dimensiondata_cloud.pfx'
default['didata-fabio']['ssl_certificate']['secret_databag']='certificate_secrets'
default['didata-fabio']['ssl_certificate']['secret_databag_item']='star_ci_dimensiondata_cloud.pfx'