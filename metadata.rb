name             'rackspace_newrelic'
maintainer       'Rackspace, US Inc.'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license          'MIT'
description      'Installs/Configures New Relic'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'

%w{ debian ubuntu redhat centos }.each do |os|
  supports os
end

recommends 'curl'

supports 'centos'
supports 'debian'
supports 'redhat'
supports 'ubuntu'

depends 'rackspace_python', '~> 2.0'
depends 'rackspace_php', '~> 2.0'

recipe 'rackspace_newrelic', 'Adds the New Relic repository, installs & configures the New Relic server monitor package.'
recipe 'rackspace_newrelic::repository', 'Adds the New Relic repository.'
recipe 'rackspace_newrelic::server-monitor', 'Installs & configures the New Relic server monitor package.'
recipe 'rackspace_newrelic::php-agent', 'Installs the New Relic PHP agent.'
recipe 'rackspace_newrelic::python-agent', 'Installs the New Relic Python agent.'
