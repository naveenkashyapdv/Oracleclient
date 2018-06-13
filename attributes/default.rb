default['oracle_client']['deps'] = [
'glibc','glibc','libstdc++','compat-db47','libaio','glibc.i686','gtk2.i686','libXtst.i686','libXft.i686','libXtst.i686','compat-libstdc++-33.i686','compat-libstdc++-33.x86_64'
]
default['yum']['add_repos'] = %w(rhel-7-server-optional-rpms rhui-REGION-rhel-server-optional rhui-REGION-rhel-server-source-extras)
default['oracle_client']['oracle_home'] = '/oracle'
default['oracle_client']['oracle_media_home'] = '/oracle/client'
default['oracle_client']['oracle_responsefile'] = '/oracle/dbclient_install.rsp'
default['oracle_client']['oracle_path'] = '/home/oracle'
default['oracle_client']['installtion_path'] = '/oracle/runInstaller'
default['oracle_client']['permissions_script'] = '/oracle/product/oracleinventory/orainstRoot.sh'
default['oracle_client']['tnsnames_file'] = '/oracle/product/12.2.0.1.0/client_1/network/admin/tnsnames.ora'
default['oracle_client']['configure_oracle_path'] = '/oracle/path.txt'
default['oracle_client']['export_path'] = '/oracle/'
default['oracle_client']['product_path'] = '/oracle/product/12.2.0.1.0/client_1'
default['oracle_client']['S3_url'] = 'https://s3-us-west-2.amazonaws.com/pathtoamazonlink/oracleclient_linuxamd64_12102_client.zip'
