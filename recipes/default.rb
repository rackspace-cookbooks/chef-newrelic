#
# Cookbook Name:: rackspace_newrelic
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

include_recipe 'rackspace_newrelic::repository'
if node['rackspace_newrelic']['web_server']['enabled'] == true
  include_recipe 'rackspace_newrelic::server-monitor'
end
