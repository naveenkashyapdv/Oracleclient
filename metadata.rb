name 'oracleclient'
maintainer 'VenkatNaveen'
maintainer_email 'venkatnaveenkashyap@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures oracle_client'
long_description 'Installs/Configures oracle_client'
version '0.2.2'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/oracle_client/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/oracle_client'
depends 'poise-archive'
depends 'user'
depends 'build-essential'
