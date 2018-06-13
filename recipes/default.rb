#
# Cookbook:: oracle_client
# Recipe:: default
# Author : Venkat Naveen 
# Copyright:: 2018, The Authors, All Rights Reserved.

node['yum']['add_repos'].each do |r|
  execute 'add_repos' do
    command "/usr/bin/yum-config-manager repos --enable #{r}"
  end
end

include_recipe 'build-essential'

node['oracle_client']['deps'].each do |pkg|
    package pkg do
        action :install
    end
end

oracle_path = node['oracle_client']['oracle_path']
bash 'create_group&user' do
  code <<-EOH
	groupadd -g 13 dba
	groupadd -g 201 oinstall
	useradd -u 204 -g dba -G oinstall -c "Oracle Service Account" oracle
	EOH
  not_if { ::File.exist?(oracle_path) }
end

directory (node['oracle_client']['oracle_home']).to_s do
  owner 'oracle'
  group 'dba'
  mode '0755'
  action :create
end

poise_archive 'oracle_media' do
  path (node['oracle_client']['S3_url']).to_s
  destination (node['oracle_client']['oracle_home']).to_s
  user 'oracle'
  group 'dba'
  not_if { ::File.exist?((node['oracle_client']['tnsnames_file']).to_s) }
end

template (node['oracle_client']['oracle_responsefile']).to_s do
  source 'dbclient_install.rsp.erb'
  owner 'oracle'
  group 'dba'
  mode '0755'
  action :create
end

execute 'oracle_client_Instillation' do
  i = 0
  until File.exist?((node['oracle_client']['product_path']).to_s)
    sleep(5)
    i += 1
    break if i >= 8
  end
  command "#{node['oracle_client']['installtion_path']} -silent -responseFile '#{node['oracle_client']['oracle_responsefile']}' -ignoreSysPrereqs -waitforcompletion -showProgress oracle.install.option=INSTALL_DB_SWONLY"
  user 'oracle'
  group 'dba'
  not_if { ::File.exist?((node['oracle_client']['tnsnames_file']).to_s) }
  sensitive true
  ignore_failure true
end

template (node['oracle_client']['configure_oracle_path']).to_s do
  source 'path.txt.erb'
  owner 'oracle'
  group 'dba'
  mode 0755
  action :create
  not_if { ::File.exist?((node['oracle_client']['configure_oracle_path']).to_s) }
end

bash 'export_oracle_path' do
  cwd node['oracle_client']['export_path']
  user 'root'
  code <<-EOH
  cat path.txt >> /etc/profile
  EOH
  not_if 'grep ORACLE_HOME /etc/profile', environment: { 'ORACLE_HOME' => '/app/oracle/product/12.2.0.1.0/client_1' }
end

template (node['oracle_client']['tnsnames_file']).to_s do
  source 'tnsnames.ora.erb'
  owner 'oracle'
  group 'dba'
  mode '0755'
  action :create
  sensitive true
end


