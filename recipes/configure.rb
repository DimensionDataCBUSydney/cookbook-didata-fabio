poise_service_user 'fabio'

directory node['didata-fabio']['conf_dir'] do
  owner 'fabio'
end

directory node['didata-fabio']['log_dir'] do
  owner 'fabio'
end

certificate=ssl_certificate 'fabio' do
  namespace node['didata-fabio']['tls']
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
    mode '0644'
  end
  directory certificate.key_path do
    owner 'fabio'
    mode '0640'
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
