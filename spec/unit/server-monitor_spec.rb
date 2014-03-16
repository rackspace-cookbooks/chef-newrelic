require 'spec_helper'

describe 'rackspace_newrelic::server-monitor' do
  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'creates the newrelic config directory' do
      expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['config_path'])
    end

    it 'creates a group' do
      expect(chef_run).to create_group(chef_run.node['rackspace_newrelic']['config_file_group'])
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file(chef_run.node['rackspace_newrelic']['config_path'] + '/nrsysmond.cfg')
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.1').converge(described_recipe) }

    it 'creates the newrelic config directory' do
      expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['config_path'])
    end

    it 'creates a group' do
      expect(chef_run).to create_group(chef_run.node['rackspace_newrelic']['config_file_group'])
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file(chef_run.node['rackspace_newrelic']['config_path'] + '/nrsysmond.cfg')
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

    it 'creates the newrelic config directory' do
      expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['config_path'])
    end

    it 'creates a group' do
      expect(chef_run).to create_group(chef_run.node['rackspace_newrelic']['config_file_group'])
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file(chef_run.node['rackspace_newrelic']['config_path'] + '/nrsysmond.cfg')
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'redhat', version: '6.3').converge(described_recipe) }

    it 'creates the newrelic config directory' do
      expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['config_path'])
    end

    it 'creates a group' do
      expect(chef_run).to create_group(chef_run.node['rackspace_newrelic']['config_file_group'])
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file(chef_run.node['rackspace_newrelic']['config_path'] + '/nrsysmond.cfg')
    end
  end
end
