#
# Cookbook Name:: fabio
# Recipe:: configure
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
      'proxy.addr'=>":#{node['didata-fabio']['port']}",
  )
else
  node.default['didata-fabio']['config']=node['didata-fabio']['config'].merge(
      'proxy.addr'=>":#{node['didata-fabio']['port']};cs=tls;",
      'proxy.cs'=>"cs=tls;type=file;cert=#{certificate.cert_path};key=#{certificate.key_path}"

  )
end

template "#{node['didata-fabio']['conf_dir']}/fabio.properties" do
  source 'fabio.properties.erb'
  notifies :restart, "poise_service[#{node['didata-fabio']['service_name']}]"
end


poise_service node['didata-fabio']['service_name'] do
  command "#{node['didata-fabio']['install_path']} -cfg #{node['didata-fabio']['conf_dir']}/fabio.properties"
  user 'fabio'
end
poise_service_options node['didata-fabio']['service_name'] do
  template 'sysvinit.service.erb'
  for_provider :sysvinit
  restart_on_update false
end
poise_service_options node['didata-fabio']['service_name'] do
  template 'systemd.service.erb'
  for_provider :systemd
  restart_on_update false
end



firewall_rule 'fabio' do
  protocol :tcp
  port node['didata-fabio']['port']
  action :create
  command :allow
end

firewall_rule 'icmp' do
  protocol :icmp
  command  :allow
end
