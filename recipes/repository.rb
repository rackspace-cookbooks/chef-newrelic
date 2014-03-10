#
# Cookbook Name:: rackspace_newrelic
# Recipe:: repository
#
# Copyright 2012-2013, Escape Studios
# Copyright 2014, Rackspace, US Inc.
#

case node['platform_family']
when 'debian', 'ubuntu'
  # trust the New Relic GPG Key
  # this step is required to tell apt that you trust the integrity of New Relic's apt repository
  gpg_key_url = "http://download.newrelic.com/#{node['rackspace_newrelic']['repository_key']}.gpg"

  remote_file "#{Chef::Config['file_cache_path']}/#{node['rackspace_newrelic']['repository_key']}.gpg" do
    source gpg_key_url
    action :create
  end

  execute "apt-key add #{Chef::Config['file_cache_path']}/#{node['rackspace_newrelic']['repository_key']}.gpg" do
    command "apt-key add #{Chef::Config['file_cache_path']}/#{node['rackspace_newrelic']['repository_key']}.gpg"
  end

  # configure the New Relic apt repository
  remote_file '/etc/apt/sources.list.d/newrelic.list' do
    source 'http://download.newrelic.com/debian/newrelic.list'
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'execute[apt-get update]', :immediately
    action :create_if_missing
  end

  execute 'apt-get update' do
    command 'apt-get update'
    action :run
  end
when 'centos', 'rhel'
  # install the newrelic-repo package, which configures a new package repository for yum
  remote_file "#{Chef::Config['file_cache_path']}/newrelic-repo-5-3.noarch.rpm" do
    source 'http://download.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm'
    action :create_if_missing
  end

  package 'newrelic-repo' do
    source "#{Chef::Config['file_cache_path']}/newrelic-repo-5-3.noarch.rpm"
    provider Chef::Provider::Package::Rpm
    action :install
  end
end
