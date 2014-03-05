#
# Cookbook Name:: rackspace_newrelic
# Attributes:: php-agent
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

default['rackspace_newrelic']['startup_mode'] = 'agent'

case node['platform_family']
when 'debian', 'ubuntu'
  default['rackspace_newrelic']['web_server']['service_name'] = 'apache2'
when 'rhel', 'centos'
  default['rackspace_newrelic']['web_server']['service_name'] = 'httpd'
else
  default['rackspace_newrelic']['web_server']['service_name'] = 'apache2'
end
