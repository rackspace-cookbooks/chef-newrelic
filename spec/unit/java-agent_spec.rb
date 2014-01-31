require 'spec_helper'

describe 'rackspace_newrelic::java-agent' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates the directory to install the jar into' do
    expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['install_dir'])
    expect(chef_run).to create_directory(chef_run.node['rackspace_newrelic']['install_dir']).with_user(chef_run.node['rackspace_newrelic']['app_user'])
    expect(chef_run.directory(chef_run.node['rackspace_newrelic']['install_dir']).owner).to eq(chef_run.node['rackspace_newrelic']['app_user'])
    expect(chef_run.directory(chef_run.node['rackspace_newrelic']['install_dir']).group).to eq(chef_run.node['rackspace_newrelic']['app_group'])
  end

  it 'downloads the newrelic jar file' do
    expect(chef_run).to create_remote_file(chef_run.node['rackspace_newrelic']['install_dir'] + '/newrelic.jar')
  end

  it 'creates newrelic java config template from newrelic.yml.java.erb' do
    expect(chef_run).to render_file(chef_run.node['rackspace_newrelic']['install_dir'] + '/newrelic.yml')
  end
end
