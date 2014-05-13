#
# Cookbook Name:: rackspace_newrelic
# Recipe:: server-monitor
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

group node['rackspace_newrelic']['config_file_group'] do
  action :create
end

directory node['rackspace_newrelic']['config_path'] do
  action :create
end

# configure the New Relic license key
template "#{node['rackspace_newrelic']['config_path']}/nrsysmond.cfg" do
  cookbook node['rackspace_newrelic']['templates_cookbook']['nrsysmond.cfg.erb']
  source 'nrsysmond.cfg.erb'
  owner 'root'
  group node['rackspace_newrelic']['config_file_group']
  mode '640'
  variables(
  license: node['rackspace_newrelic']['server_monitoring']['license'],
  logfile: node['rackspace_newrelic']['server_monitoring']['logfile'],
  loglevel: node['rackspace_newrelic']['server_monitoring']['loglevel'],
  proxy: node['rackspace_newrelic']['server_monitoring']['proxy'],
  ssl: node['rackspace_newrelic']['server_monitoring']['ssl'],
  ssl_ca_path: node['rackspace_newrelic']['server_monitoring']['ssl_ca_path'],
  ssl_ca_bundle: node['rackspace_newrelic']['server_monitoring']['ssl_ca_bundle'],
  pidfile: node['rackspace_newrelic']['server_monitoring']['pidfile'],
  collector_host: node['rackspace_newrelic']['server_monitoring']['collector_host'],
  timeout: node['rackspace_newrelic']['server_monitoring']['timeout']
  )
end

package node['rackspace_newrelic']['service_name'] do
  action :install
end

# This is a bit of a hack to get around starting the service in testing
service node['rackspace_newrelic']['service_name'] do
  supports status: true, restart: true, reload: true, condrestart: true
  action [:enable, :start]
  not_if { node['rackspace_newrelic']['server_monitoring']['license'] == 'CHANGE_ME' }
end
