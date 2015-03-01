default[:clockspeed][:wait] = 541 # Initial wait interval for adjustment mark (in seconds)
default[:clockspeed][:wait_max] = 2617923 # Maximum time to wait for adjustment mark (in seconds)
default[:clockspeed][:user] = 'clocksd' # User to run services as (reduce privileges for safety)

#Toggles for each service (if for some reason you need to disable some of this)
default[:clockspeed][:clockspeed_enabled] = true
default[:clockspeed][:clockspeed_adjust_enabled] = true
default[:clockspeed][:taiclockd_enabled] = true

# Debian/Ubuntu defaults for service placement
default[:clockspeed][:sv_base] = '/etc/sv' # Where to define our services
default[:clockspeed][:service_base] = '/etc/service' # Where link our services to enable
default[:clockspeed][:prefix] = '/usr/local'
default[:clockspeed][:djb_base] = File.join(node[:clockspeed][:prefix],"djb")

# Source details
default[:clockspeed][:source_md5sum] = '425614174fcfe2ad42d22d3d02e2d567'
default[:clockspeed][:version] = '0.62'
default[:clockspeed][:source_url] = "http://cr.yp.to/clockspeed/clockspeed-#{node[:clockspeed][:version]}.tar.gz"
# WARNING: Enabling this will send a mail to djb telling him about the build (expects a BSD-like mail and MTA to be present)
default[:clockspeed][:report_build] = false 
default[:clockspeed][:build_report_name] = 'Kevin Berry'
