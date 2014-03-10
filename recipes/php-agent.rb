#
# Cookbook Name:: rackspace_newrelic
# Recipe:: php-agent
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

include_recipe 'rackspace_newrelic::repository'
include_recipe 'rackspace_php'

# configure New Relic INI file and set the daemon related options (documented at /usr/lib/newrelic-php5/scripts/newrelic.ini.template)
# and restart the web server in order to pick up the new settings
template "#{node['rackspace_php']['ext_conf_dir']}/newrelic.ini" do
  cookbook node['rackspace_newrelic']['templates_cookbook']['newrelic.ini.php.erb']
  source 'newrelic.ini.php.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    enabled: node['rackspace_newrelic']['application_monitoring']['enabled'],
    license: node['rackspace_newrelic']['application_monitoring']['license'],
    logfile: node['rackspace_newrelic']['application_monitoring']['logfile'],
    loglevel: node['rackspace_newrelic']['application_monitoring']['loglevel'],
    appname: node['rackspace_newrelic']['application_monitoring']['appname'],
    daemon_logfile: node['rackspace_newrelic']['application_monitoring']['daemon']['logfile'],
    daemon_loglevel: node['rackspace_newrelic']['application_monitoring']['daemon']['loglevel'],
    daemon_port: node['rackspace_newrelic']['application_monitoring']['daemon']['port'],
    daemon_max_threads: node['rackspace_newrelic']['application_monitoring']['daemon']['max_threads'],
    daemon_ssl: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl'],
    daemon_ssl_ca_path: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_path'],
    daemon_ssl_ca_bundle: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_bundle'],
    daemon_proxy: node['rackspace_newrelic']['application_monitoring']['daemon']['proxy'],
    daemon_pidfile: node['rackspace_newrelic']['application_monitoring']['daemon']['pidfile'],
    daemon_location: node['rackspace_newrelic']['application_monitoring']['daemon']['location'],
    daemon_collector_host: node['rackspace_newrelic']['application_monitoring']['daemon']['collector_host'],
    daemon_dont_launch: node['rackspace_newrelic']['application_monitoring']['daemon']['dont_launch'],
    capture_params: node['rackspace_newrelic']['application_monitoring']['capture_params'],
    ignored_params: node['rackspace_newrelic']['application_monitoring']['ignored_params'],
    error_collector_enable: node['rackspace_newrelic']['application_monitoring']['error_collector']['enable'],
    error_collector_record_database_errors: node['rackspace_newrelic']['application_monitoring']['error_collector']['record_database_errors'],
    error_collector_prioritize_api_errors: node['rackspace_newrelic']['application_monitoring']['error_collector']['prioritize_api_errors'],
    browser_monitoring_auto_instrument: node['rackspace_newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'],
    transaction_tracer_enable: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['enable'],
    transaction_tracer_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['threshold'],
    transaction_tracer_detail: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['detail'],
    transaction_tracer_slow_sql: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['slow_sql'],
    transaction_tracer_stack_trace_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'],
    transaction_tracer_explain_threshold: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'],
    transaction_tracer_record_sql: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['record_sql'],
    transaction_tracer_custom: node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['custom'],
    framework: node['rackspace_newrelic']['application_monitoring']['framework'],
    webtransaction_name_remove_trailing_path: node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path'],
    webtransaction_name_functions: node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['functions'],
    webtransaction_name_files: node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['files']
  )
  action :create
  notifies :restart, "service[#{node['rackspace_newrelic']['web_server']['service_name']}]", :delayed
end

# install/update latest php agent
package 'newrelic-php5' do
  action :upgrade
  # notifies :run, 'execute[newrelic-install]', :immediately
end

package node['rackspace_newrelic']['web_server']['service_name']

service node['rackspace_newrelic']['web_server']['service_name'] do
  supports status: true, start: true, stop: true, restart: true
end

service 'newrelic-daemon' do
  supports status: true, start: true, stop: true, restart: true
end

# run newrelic-install
execute 'newrelic-install' do
  command 'newrelic-install install'
  action :nothing
  notifies :restart, "service[#{node['rackspace_newrelic']['web_server']['service_name']}]", :delayed
end

# https://newrelic.com/docs/php/newrelic-daemon-startup-modes
Chef::Log.info("newrelic-daemon startup mode: #{node['rackspace_newrelic']['startup_mode']}")

case node['rackspace_newrelic']['startup_mode']
when 'agent'
  # agent startup mode
  # ensure that the daemon isn't currently running
  service 'newrelic-daemon' do
    action [:disable, :stop] # stops the service if it's running and disables it from starting at system boot time
  end

  # ensure that the file /etc/newrelic/newrelic.cfg does not exist if it does, move it aside (or remove it)
  execute 'newrelic-backup-cfg' do
    command 'mv /etc/newrelic/newrelic.cfg /etc/newrelic/newrelic.cfg.external'
    only_if { File.exists?('/etc/newrelic/newrelic.cfg') }
  end

  # ensure that the file /etc/newrelic/upgrade_please.key does not exist if it does, move it aside (or remove it)
  execute 'newrelic-backup-key' do
    command 'mv /etc/newrelic/upgrade_please.key /etc/newrelic/upgrade_please.key.external'
    only_if { File.exists?('/etc/newrelic/upgrade_please.key') }
  end
when 'external'
  # external startup mode
  # configure proxy daemon settings
  template '/etc/newrelic/newrelic.cfg' do
    cookbook node['rackspace_newrelic']['templates_cookbook']['newrelic.cfg.erb']
    source 'newrelic.cfg.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      daemon_pidfile: node['rackspace_newrelic']['application_monitoring']['daemon']['pidfile'],
      daemon_logfile: node['rackspace_newrelic']['application_monitoring']['daemon']['logfile'],
      daemon_loglevel: node['rackspace_newrelic']['application_monitoring']['daemon']['loglevel'],
      daemon_port: node['rackspace_newrelic']['application_monitoring']['daemon']['port'],
      daemon_ssl: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl'],
      daemon_proxy: node['rackspace_newrelic']['application_monitoring']['daemon']['proxy'],
      daemon_ssl_ca_path: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_path'],
      daemon_ssl_ca_bundle: node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_bundle'],
      daemon_max_threads: node['rackspace_newrelic']['application_monitoring']['daemon']['max_threads'],
      daemon_collector_host: node['rackspace_newrelic']['application_monitoring']['daemon']['collector_host']
    )
    action :create
    notifies :restart, 'service[newrelic-daemon]', :immediately
    notifies :restart, "service[#{node['rackspace_newrelic']['web_server']['service_name']}]", :delayed
  end

  service 'newrelic-daemon' do
    action [:enable, :start] # starts the service if it's not running and enables it to start at system boot time
  end
else
  Chef::Application.fatal!("#{node['rackspace_newrelic']['startup_mode']} is not a valid newrelic-daemon startup mode.")
end
