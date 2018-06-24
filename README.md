**OracleClient**



**This cookbook is concerned with a full installation of OracleClient. This will give access to oracle-cient, sqlplus etc**

**Platform Support**

| Os            | Version       | 
| ------------- |:-------------:| 
| Centos        | 6             | 
| RHEL          | 7             | 



Usage\
Place a dependency on the OracleClient cookbook in your cookbook's metadata file include_recipe 'build-essential' depends 'build-essential'\

Required pakages package ['glibc', 'compat-libstdc++-33', 'compat-db', 'ld-linux.so.2']\
INSTALLED from the response file template\.
####################


>oracle.install.responseFileVersion=/oracle/install/rspfmt_clientinstall_response_schema_v12.1.0\
>ORACLE_HOSTNAME=localhost\
>UNIX_GROUP_NAME=root\
>INVENTORY_LOCATION=/app/oracle/oracleclient\
>SELECTED_LANGUAGES=en\
>ORACLE_HOME=/app/oracle/product/12.2.0.1.0/client_1\
>ORACLE_BASE=/app/oracle\
>oracle.install.client.installType=Administrator\
>oracle.installer.autoupdates.option=SKIP_UPDATES\
>PROXY_PORT=0\


Code Block\


template "#{node['Oracle_client']['oracle_responsefile']}" do
source 'dbclient_install.rsp.erb'
owner 'oracle'
group 'dba'
mode '0755'
action :create
end

execute 'oracle_client_Instillation' do
command "#{node['Oracle_client']['installtion_path']} -silent -responseFile '#{node['Oracle_client']['oracle_responsefile']}' -ignoreSysPrereqs -waitforcompletion -showProgress oracle.install.option=INSTALL_DB_SWONLY"
user 'oracle'
group 'dba'
not_if{::File.exist?("#{node['oracle_client']['Product_path']}")}
ignore_failure true
end
