# SPDX-License-Identifier: ISC

ENV["VAGRANT_NO_PARALLEL"] = "yes"

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-libvirt"]

  config.vm.provider "libvirt" do |v|
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.define "nixos" do |c|
    c.vm.box = "jcmdln/nixos"
    c.vm.box_version = "22.05"
  end
end
