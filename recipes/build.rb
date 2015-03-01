#
# Cookbook Name:: clockspeed
# Recipe:: build
#
# Copyright 2015, Kevin Berry <kevin@opensourcealchemist.com>
#
# Licensed under the MIT License.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential' # We expect build-essential to know what platforms it supports

#NOTE: This is a djb "classic" build (make setup check)

unless File.exists?(File.join(node['clockspeed']['prefix'],'bin','clockspeed'))
  #TODO: Abstract this out into a common djb-classic paradigm (or transform into slashpackage)
  directory node[:clockspeed][:djb_base] do
    mode 1755
  end

  dist_dir = File.join(node[:clockspeed][:djb_base],'dist')
  patch_dir = File.join(node[:clockspeed][:djb_base],'patches')
  build_dir = File.join(node[:clockspeed][:djb_base],'build')
  build_root = File.join(build_dir,"clockspeed-#{node[:clockspeed][:version]}")

  [dist_dir,patch_dir,build_dir].each do |dir|
    directory dir do
      mode 755
    end
  end

  tarball = "clockspeed-#{node['clockspeed']['version']}.tar.bz2"

  remote_file File.join(dist_dir,tarball) do
    source node[:clockspeed][:source_url]
    checksum node[:clockspeed][:source_md5sum]
  end

  cookbook_file File.join(patch_dir,"clockspeed-#{node[:clockspeed][:version]}.errno.patch")

  bash 'extract_clockspeed' do
    cwd build_dir
    code "tar xjf #{tarball}"
    not_if { File.directory?(build_root) }
  end

  bash 'patch_clockspeed' do
    cwd build_root
    code "patch -p1 < #{File.join(patch_dir,"clockspeed-#{node[:clockspeed][:version]}.errno.patch")}"
  end

  bash 'compile_clockspeed' do
    cwd build_root
    code 'make setup check'
  end

  bash 'report_build' do
    cwd build_root
    code "(echo '#{node[:clockspeed][:build_report_name]}'; cat `cat SYSDEPS`) | mail djb-qst@cr.yp.to"
  end if node[:clockspeed][:report_build]

end
