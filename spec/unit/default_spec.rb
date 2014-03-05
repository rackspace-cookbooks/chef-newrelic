require 'spec_helper'

describe 'rackspace_newrelic::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the repository recipe' do
    expect(chef_run).to include_recipe('rackspace_newrelic::repository')
  end

  it 'includes the server-monitor recipe' do
    expect(chef_run).to include_recipe('rackspace_newrelic::server-monitor')
  end
end
