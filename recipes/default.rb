
#1. build
include_recipe "clockspeed::build"
#2. configure
include_recipe "clockspeed::conf_files"
#3. enable services
include_recipe "clockspeed::services"
