#
# Cookbook Name:: rails_multi_vm
# Recipe:: app
#
# Copyright (c) 2015 Blake Tidwell
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

include_recipe "apt"

include_recipe "build-essential"

# Holy package nightmare
# build-essential bison openssl libreadline6 libreadline6-dev curl
# git-core
# zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf
# libc6-dev ncurses-dev automake
# libtool

%w(libffi-dev zlibc libgcrypt11
  libgcrypt11-dev zlib1g-dev
  openssl libssl-dev).each do |pkg|
  package pkg
end

# XXX: Have to manually include ruby_build in run list
# due to current behavior of tagged release.
# include_recipe "ruby_build"

include_recipe "rbenv::system"
include_recipe "rbenv::vagrant"

rbenv_global node['rbenv']['rubies'][0] 

