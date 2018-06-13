# # encoding: utf-8

# Inspec test for recipe oracle_client::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe user('oracle') do
  it { should exist }
  it { should belong_to_group 'dba' }
end

describe group('dba') do
  it { should exist }
end

describe template('/app/oracle/dbclient_install.rsp.erb') do
  it { should be_a_file }
  it { should be_owned_by 'oracle' }
  it { should be_grouped_into 'dba' }
  it { should contain 'UNIX_GROUP_NAME=root' }
  it { should contain 'INVENTORY_LOCATION=/app/oracle/oracleclient' }
  it { should contain 'ORACLE_HOME=' }
  it { should contain 'ORACLE_BASE=' }
end

# Oracle Base
describe file('/app/oracle') do
  it { should be_a_directory }
  it { should be_owned_by 'oracle' }
  it { should be_grouped_into 'dba' }
end

describe file('app/oracle/product/12.2.0.1.0/client_1/bin/sqlplus') do
  it { should be_a_file }
  it { should be_owned_by 'oracle' }
end
