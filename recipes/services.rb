[node[:clockspeed][:sv_base],node[:clockspeed][:service_base]].each do |dir|
  unless File.exists?(dir)
    directory dir do
      mode 0755
    end
  end
end

services = %w{clockspeed clockspeed_adjust taiclockd}.inject([]) do |svcs, svc|
  svcs << svc unless node[:clockspeed]["#{svc}_enabled"] == false
end

services.each do |svc|
  
  link "/etc/init.d/#{svc}" do
    to '/usr/bin/sv'
  end if node[:platform_family] == "debian"

  directory File.join(node[:clockspeed][:sv_base],svc) do
    action :create
  end

  file File.join(node[:clockspeed][:sv_base],svc,'finish') do
    content <<-BASH
#!/bin/bash
/bin/true
    BASH
    mode 0700
  end

  directory File.join(node[:clockspeed][:sv_base],svc,'log') do
    action :create
  end

  link File.join(node[:clockspeed][:sv_base],svc,'log','run') do
    to '/usr/local/bin/rsvlog'
  end

  file File.join(node[:clockspeed][:sv_base],svc,'log','conf') do
    content <<-TXT
USERGROUP=#{node[:clockspeed][:user]}
    TXT
  end

  template File.join(node[:clockspeed][:sv_base],svc,'run') do
    owner app_user
    mode 0755
    source "sv-#{svc}-run.erb"
  end

  link File.join(node[:clockspeed][:service_base],svc) do
    to File.join(node[:clockspeed][:sv_base],svc)
  end

  service svc do
    provider node.platform =~ /ubuntu|debian/ ? Chef::Provider::Service::Init::Debian : Chef::Provider::Service::Init::Redhat # rubocop:disable Metrics/LineLength
    supports status: true, restart: true, stop: true, start: true
    action :start
    only_if "file #{File.join(node[:clockspeed][:service_base],svc,'supervise','ok')}"
  end
end
