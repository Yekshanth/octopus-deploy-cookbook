#
# Author:: Brent Montague (<bmontague@cvent.com>)
# Cookbook Name:: octopus-deploy
# Recipe:: server
#
# Copyright:: Copyright (c) 2015 Cvent, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

installer = node['octopus']['server']['installer']
server_installer = ::File.join(Chef::Config[:file_cache_path], 'octopus-server.msi')

remote_file server_installer do
  source installer['url']
  checksum installer['checksum']
end

windows_package installer['display_name'] do
  action :install
  source server_installer
  version installer['version'] if installer['version']
  installer_type :msi
  options '/passive /norestart'
end

