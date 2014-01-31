require 'spec_helper'

describe 'rackspace_newrelic::python-agent' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before do
    stub_command("/usr/bin/python -c 'import setuptools'").and_return(true)
  end

  it 'includes the python::pip recipe' do
    expect(chef_run).to include_recipe('rackspace_python::pip')
  end

  it 'creates newrelic config template from newrelic.ini.python.erb' do
    expect(chef_run).to render_file('/etc/newrelic/newrelic.ini')
  end
end
