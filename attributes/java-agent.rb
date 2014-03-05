#
# Cookbook Name:: rackspace_newrelic
# Attributes:: java-agent
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

default['rackspace_newrelic']['https_download'] = 'https://download.newrelic.com/newrelic/java-agent/newrelic-agent/2.21.3/newrelic-agent-2.21.3.jar'
default['rackspace_newrelic']['jar_file'] = 'newrelic-agent-2.21.3.jar'
default['rackspace_newrelic']['install_dir'] = '/etc/newrelic'
default['rackspace_newrelic']['app_user'] = 'newrelic'
default['rackspace_newrelic']['app_group'] = 'newrelic'
default['rackspace_newrelic']['audit_mode'] = false
default['rackspace_newrelic']['log_file_count'] = 1
default['rackspace_newrelic']['log_limit_in_kbytes'] = 0
default['rackspace_newrelic']['log_daily'] = true
