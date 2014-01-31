#
# Cookbook Name:: rackspace_newrelic
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

##############
# BASIC CONFIG
##############
# license(s)
default['rackspace_newrelic']['server_monitoring']['license'] = 'CHANGE_ME'
default['rackspace_newrelic']['application_monitoring']['license'] = 'CHANGE_ME'

##################
# ADVANCED CONFIG
##################
# server monitoring
default['rackspace_newrelic']['server_monitoring']['logfile'] = nil
default['rackspace_newrelic']['server_monitoring']['loglevel'] = nil
default['rackspace_newrelic']['server_monitoring']['proxy'] = nil
default['rackspace_newrelic']['server_monitoring']['ssl'] = nil
default['rackspace_newrelic']['server_monitoring']['ssl_ca_bundle'] = nil
default['rackspace_newrelic']['server_monitoring']['ssl_ca_path'] = nil
default['rackspace_newrelic']['server_monitoring']['pidfile'] = nil
default['rackspace_newrelic']['server_monitoring']['collector_host'] = nil
default['rackspace_newrelic']['server_monitoring']['timeout'] = nil

# application monitoring
default['rackspace_newrelic']['application_monitoring']['enabled'] = nil
default['rackspace_newrelic']['application_monitoring']['logfile'] = nil
default['rackspace_newrelic']['application_monitoring']['loglevel'] = nil
default['rackspace_newrelic']['application_monitoring']['appname'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['logfile'] = '/var/log/newrelic/newrelic-daemon.log'
default['rackspace_newrelic']['application_monitoring']['daemon']['loglevel'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['port'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['max_threads'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['ssl'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_path'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_bundle'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['proxy'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['pidfile'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['location'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['collector_host'] = nil
default['rackspace_newrelic']['application_monitoring']['daemon']['dont_launch'] = nil
default['rackspace_newrelic']['application_monitoring']['capture_params'] = nil
default['rackspace_newrelic']['application_monitoring']['ignored_params'] = nil
default['rackspace_newrelic']['application_monitoring']['error_collector']['enable'] = nil
default['rackspace_newrelic']['application_monitoring']['error_collector']['record_database_errors'] = nil
default['rackspace_newrelic']['application_monitoring']['error_collector']['prioritize_api_errors'] = nil
default['rackspace_newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['enable'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['threshold'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['detail'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['slow_sql'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['record_sql'] = nil
default['rackspace_newrelic']['application_monitoring']['transaction_tracer']['custom'] = nil
default['rackspace_newrelic']['application_monitoring']['framework'] = nil
default['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path'] = nil
default['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['functions'] = nil
default['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['files'] = nil
