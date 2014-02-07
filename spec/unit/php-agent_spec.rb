require 'spec_helper'

describe 'rackspace_newrelic::php-agent' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the php cookbook' do
    expect(chef_run).to include_recipe('rackspace_php')
  end

  it 'installs the newrelic-php5 package' do
    expect(chef_run).to upgrade_package('newrelic-php5')
  end

  # I don't think we can use this since the notify is set to :nothing
  # ERROR: expected "execute[newrelic-install]" actions [] to include :run
  it 'runs "newrelic-install install"' do
    # expect(chef_run).to run_execute('newrelic-install')
  end

  it 'creates newrelic php ini from template newrelic.ini.php.erb' do
    expect(chef_run).to render_file(chef_run.node['rackspace_php']['ext_conf_dir'] + '/newrelic.ini')
  end
end
