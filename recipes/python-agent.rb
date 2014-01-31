#
# Cookbook Name:: rackspace_newrelic
# Recipe:: python-agent
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace US Inc.
#

include_recipe 'rackspace_python::pip'

directory node['rackspace_newrelic']['config_path'] do
  action :create
end

# install latest python agent
rackspace_python_pip 'newrelic' do
  action :install
  if node['rackspace_newrelic']['python_version'] != 'latest'
    version node['rackspace_newrelic']['python_version']
  end
end

# configure your New Relic license key
template '/etc/newrelic/newrelic.ini' do
  cookbook node['rackspace_sudo']['templates_cookbook']['newrelic.ini.python.erb']
  source 'newrelic.ini.python.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    license: node['rackspace_newrelic']['application_monitoring']['license'],
    appname: node['rackspace_newrelic']['application_monitoring']['appname'],
    enabled: node['rackspace_newrelic']['application_monitoring']['enabled'],
    logfile: node['rackspace_newrelic']['application_monitoring']['logfile'],
    loglevel: node['rackspace_newrelic']['application_monitoring']['loglevel'],
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
