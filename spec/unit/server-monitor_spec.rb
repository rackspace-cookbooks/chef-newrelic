require 'spec_helper'

describe 'rackspace_newrelic::server-monitor' do
  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

    it 'creates the newrelic config directory' do
      expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['config_path'])
    end

    it 'creates a group' do
      expect(chef_run).to create_group(chef_run.node['rackspace_newrelic']['config_file_group'])
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to create_template('/etc/newrelic/nrsysmond.cfg')
    end

    it 'installs the package newrelic-sysmond' do
      expect(chef_run).to install_package('newrelic-sysmond')
    end

    it 'starts the newrelic-sysmond service' do
      expect(chef_run).to start_service('newrelic-sysmond')
    end

    it 'enableds the newrelic-sysmond service' do
      expect(chef_run).to enable_service('newrelic-sysmond')
    end
  end
end
