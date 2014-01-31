#
# Cookbook Name:: rackspace_newrelic
# Recipe:: java-agent
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

# create the directory to install the jar into
directory node['rackspace_newrelic']['install_dir'] do
  owner node['rackspace_newrelic']['app_user']
  group node['rackspace_newrelic']['app_group']
  mode 0775
  action :create
end

local_file = node['rackspace_newrelic']['install_dir'] + '/newrelic.jar'

group node['rackspace_newrelic']['app_group'] do
  action :create
end

user node['rackspace_newrelic']['app_user'] do
  action :create
  group node['rackspace_newrelic']['app_group']
end

remote_file local_file do
  source node['rackspace_newrelic']['https_download']
  owner node['rackspace_newrelic']['app_user']
  group node['rackspace_newrelic']['app_group']
  mode 0664
end

if node['rackspace_newrelic']['application_monitoring']['appname'].nil?
  node.set['newrelic']['application_monitoring']['appname'] = node['hostname']
end

# configure your New Relic license key
conf_file = node['rackspace_newrelic']['install_dir'] + '/newrelic.yml'
template conf_file do
  cookbook node['rackspace_sudo']['templates_cookbook']['newrelic.yml.java.erb']
  source 'newrelic.yml.java.erb'
  owner node['rackspace_newrelic']['app_user']
  group node['rackspace_newrelic']['app_group']
  mode 0644
  variables(
    license: node['rackspace_newrelic']['application_monitoring']['license'],
    appname: node['rackspace_newrelic']['application_monitoring']['appname'],
    logfile: node['rackspace_newrelic']['application_monitoring']['logfile'],
    loglevel: node['rackspace_newrelic']['application_monitoring']['loglevel'],
    audit_mode: node['rackspace_newrelic']['audit_mode'],
    log_file_count: node['rackspace_newrelic']['log_file_count'],
    log_limit_in_kbytes: node['rackspace_newrelic']['log_limit_in_kbytes'],
    log_daily: node['rackspace_newrelic']['log_daily'],
    daemon_ssl: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl'],
    capture_params: node['rackspace_newrelic']['application_monitoring']['capture_params'],
    ignored_params: node['rackspace_newrelic']['application_monitoring']['ignored_params'],
    transaction_tracer_enable: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['enable'],
    transaction_tracer_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['threshold'],
    transaction_tracer_record_sql: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['record_sql'],
    transaction_tracer_stack_trace_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'],
    transaction_tracer_slow_sql: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['slow_sql'],
    transaction_tracer_explain_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'],
    error_collector_enable: node['rackspace_newrelic']['application_monitoring']['error_collector']['enable'],
    browser_monitoring_auto_instrument: node['rackspace_newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']
  )
  action :create
end
