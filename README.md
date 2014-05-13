Description
===========

This cookbook provides an easy way to install the New Relic PHP agent and the New Relic server monitor.

More information?
* https://newrelic.com/docs/server/new-relic-for-server-monitoring
* https://newrelic.com/docs/php/new-relic-for-php
* https://newrelic.com/docs/python/new-relic-for-python

Requirements
============

## Chef version:

Make sure you run Chef >= 0.10.0.

## Cookbooks:

This cookbook depends on the following cookbooks:
* rackspace_php
* rackspace_python

This cookbook recommends on the following cookbooks:

* curl

### Depending on your environment, these recommended cookbooks are actual dependencies (depends):
* Installing the PHP agent? You'll need the php cookbook to be available.
* Installing the Python agent? You'll need the python cookbook to be available.

* Want to make use of deployments? You'll need the curl cookbook to be available.

## Platforms:

* Debian
* Ubuntu
* RHEL
* CentOS

Attributes
==========

## default.rb:

### BASIC
* `node['rackspace_newrelic']['server_monitoring']['license']` - Your New Relic license key for server monitoring purposes (usually same license key as application monitoring license)
* `node['rackspace_newrelic']['application_monitoring']['license']` - Your New Relic license key for application monitoring purposes (usually same license key as server monitoring license)

### ADVANCED
* `node['rackspace_newrelic']['server_monitoring']['logfile']`
* `node['rackspace_newrelic']['server_monitoring']['loglevel']`
* `node['rackspace_newrelic']['server_monitoring']['proxy']`
* `node['rackspace_newrelic']['server_monitoring']['ssl']`
* `node['rackspace_newrelic']['server_monitoring']['ssl_ca_bundle']`
* `node['rackspace_newrelic']['server_monitoring']['ssl_ca_path']`
* `node['rackspace_newrelic']['server_monitoring']['pidfile']`
* `node['rackspace_newrelic']['server_monitoring']['collector_host']`
* `node['rackspace_newrelic']['server_monitoring']['timeout']`
* `node['rackspace_newrelic']['application_monitoring']['enabled']`
* `node['rackspace_newrelic']['application_monitoring']['logfile']`
* `node['rackspace_newrelic']['application_monitoring']['loglevel']`
* `node['rackspace_newrelic']['application_monitoring']['appname']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['logfile']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['loglevel']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['port']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['max_threads']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['ssl']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_path']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['ssl_ca_bundle']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['proxy']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['pidfile']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['location']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['collector_host']`
* `node['rackspace_newrelic']['application_monitoring']['daemon']['dont_launch']`
* `node['rackspace_newrelic']['application_monitoring']['capture_params']`
* `node['rackspace_newrelic']['application_monitoring']['ignored_params']`
* `node['rackspace_newrelic']['application_monitoring']['error_collector']['enable']`
* `node['rackspace_newrelic']['application_monitoring']['error_collector']['record_database_errors']`
* `node['rackspace_newrelic']['application_monitoring']['error_collector']['prioritize_api_errors']`
* `node['rackspace_newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['enable']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['threshold']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['detail']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['slow_sql']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['record_sql']`
* `node['rackspace_newrelic']['application_monitoring']['transaction_tracer']['custom']`
* `node['rackspace_newrelic']['application_monitoring']['framework']`
* `node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path']`
* `node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['functions']`
* `node['rackspace_newrelic']['application_monitoring']['webtransaction']['name']['files']`

## repository.rb:
* `node['rackspace_newrelic']['repository_key']` - The New Relic repository key, defaults to "548C16BF"

## php-agent.rb:
* `node['rackspace_newrelic']['startup_mode']` - The newrelic-daemon startup mode ("agent"/"external"), defaults to "agent"
* `node['rackspace_newrelic']['web_server']['service_name']` - The web server service name, defaults to "apache2"

## python-agent.rb:
* `node['rackspace_newrelic']['python_version']` - Defaults to "latest". Version numbers can be found at http://download.newrelic.com/python_agent/release/

## server-monitor.rb:
* `node['rackspace_newrelic']['service_name']` - The New Relic server monitoring service name, defaults to "newrelic-sysmond"
* `node['rackspace_newrelic']['config_path']` - The New Relic server monitoring config path, defaults to "/etc/newrelic"
* `node['rackspace_newrelic']['config_file_group']` - The New Relic server monitoring config file group, defaults to "newrelic"

## java-agent.rb:
* `node['rackspace_newrelic']['https_download']` - The url to download the jar vor the NewRelic java agent
* `node['rackspace_newrelic']['jar_file']` - The name of the newrelic jar file
* `node['rackspace_newrelic']['install_dir']` - The directory to install the newrelic jar and config file
* `node['rackspace_newrelic']['app_user']` - The user that runs the java application that will use the New Relic java agent
* `node['rackspace_newrelic']['app_group']` - The group for the app_user
* `node['rackspace_newrelic']['audit_mode']` - Boolean, Log all data to and from New Relic in plain text
* `node['rackspace_newrelic']['log_file_count']` - The number of log files to use
* `node['rackspace_newrelic']['log_limit_in_kbytes']` - The maximum number of bytes to write to any one log file
* `node['rackspace_newrelic']['log_daily']` - Override other log rolling configuration and roll the logs daily

Resources / Providers
=====================

The deployment LWRP sends deployment information to New Relic.

## Actions
:notify - Notify New Relic of a deployment

## Attribute parameters
api_key - Your New Relic API key
app_name - The name of the application, found in the newrelic.yml file
app_id - The ID # of the application
description - Text annotation for the deployment — notes for you
revision - The revision number from your source control system (SVN, git, etc.)
changelog - A list of changes for this deployment
user - The name of the user/process that triggered this deployment

Usage
=====

1)
include `recipe[rackspace_newrelic]` in a run list to implicly run `recipe[rackspace_newrelic:repository]` and `recipe[rackspace_newrelic::server-monitor]`
- OR -
include the bits and pieces explicitly in a run list:
`recipe[rackspace_newrelic::repository]`
`recipe[rackspace_newrelic::server-monitor]`
`recipe[rackspace_newrelic::php-agent]`
`recipe[rackspace_newrelic::python-agent]`

2)
	change the `node['rackspace_newrelic']['server_monitoring']['license']` and `node['rackspace_newrelic']['application_monitoring']['license']` attributes to your New Relic license keys
	--- OR ---
	override the attributes on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [New Relic home page] (http://newrelic.com/)
* [New Relic for Server Monitoring] (https://newrelic.com/docs/server/new-relic-for-server-monitoring)
* [New Relic for PHP] (https://newrelic.com/docs/php/new-relic-for-php)
* [newrelic-daemon startup modes] (https://newrelic.com/docs/php/newrelic-daemon-startup-modes)
* [New Relic for Python] (https://newrelic.com/docs/python/new-relic-for-python)
* ["newrelic" cookbook by heavywater on github] (https://github.com/heavywater/chef-newrelic)
* ["newrelic_monitoring" cookbook on community.opscode.com] (http://community.opscode.com/cookbooks/newrelic_monitoring)
* ["newrelic_monitoring" cookbook on github] (https://github.com/8thBridge/chef-newrelic-monitoring)
* a very big thanks to heavywater <darrin@heavywater.ca> for the original version of this cookbook

License and Authors
===================

Author: David Joos <david@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2012-2013, Escape Studios

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
