#
# Cookbook Name:: rackspace_newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

default['rackspace_newrelic']['web_server']['enabled'] = false
default['rackspace_newrelic']['service_name'] = 'newrelic-sysmond'
default['rackspace_newrelic']['config_path'] = '/etc/newrelic'
default['rackspace_newrelic']['config_file_group'] = 'newrelic'
