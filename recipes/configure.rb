Chef::Recipe.send(:include, Vault::Helper)

include_recipe 'chef-vault'

vault_private_data_bag=node['devops_vault']['secret_databag']
vault_private_data_bag_item=node['devops_vault']['secret_databag_item']
token = chef_vault_item(vault_private_data_bag, vault_private_data_bag_item)['value']

chef_gem 'vault'

configure_vault(node['devops_vault']['url'],token)

fabio_cert = get_vault_data(node['devops_vault']['root'],node['devops_vault']['fabio_cert_path'])

certificate = fabio_cert.data[:certificate]
private_key = fabio_cert.data[:private_key]

file "#{node['didata-fabio']['tls']['ssl_cert']['path']}" do
  content certificate
  owner fabio
end

file "#{node['didata-fabio']['tls']['ssl_key']['path']}" do
  content private_key
  owner fabio
end

poise_service_user 'fabio'

directory node['didata-fabio']['conf_dir'] do
  owner 'fabio'
end

directory node['didata-fabio']['log_dir'] do
  owner 'fabio'
end

certificate=ssl_certificate 'fabio' do
  namespace node['didata-fabio']['tls']
  owner 'fabio'
  only_if node['didata-fabio']['tls']['enabled'].to_s
end
if certificate.nil?
  node.default['didata-fabio']['config']=node['didata-fabio']['config'].merge(
      'proxy.addr' => ":#{node['didata-fabio']['port']}",
  )
else
  node.default['didata-fabio']['config']=node['didata-fabio']['config'].merge(
      'proxy.addr' => ":#{node['didata-fabio']['port']};cs=tls;",
      'proxy.cs' => "cs=tls;type=file;cert=#{certificate.cert_path};key=#{certificate.key_path}"
  )
  directory certificate.cert_path do
    owner 'fabio'
  end
  directory certificate.key_path do
    owner 'fabio'
  end

end

template "#{node['didata-fabio']['conf_dir']}/fabio.properties" do
  source 'fabio.properties.erb'
  notifies :restart, "poise_service[#{node['didata-fabio']['service_name']}]"
end

execute 'allow fabio to bind on <1024 ports' do
  command 'setcap cap_net_bind_service=+ep $(realpath $(which fabio))'
end

poise_service node['didata-fabio']['service_name'] do
  command "#{node['didata-fabio']['install_path']} -cfg #{node['didata-fabio']['conf_dir']}/fabio.properties"
  user 'fabio'
end
poise_service_options node['didata-fabio']['service_name'] do
  template 'sysvinit.service.erb'
  for_provider :sysvinit
end

poise_service_options node['didata-fabio']['service_name'] do
  template 'systemd.service.erb'
  for_provider :systemd
end


firewall_rule 'fabio' do
  protocol :tcp
  port node['didata-fabio']['port']
  action :create
  command :allow
end

firewall_rule 'icmp' do
  protocol :icmp
  command :allow
end
