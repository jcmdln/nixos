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

  # FIXME: There's probably a simpler way to do this
  config.vm.provision "file", source: "./flake.lock", destination: "$HOME/flake.lock"
  config.vm.provision "file", source: "./flake.nix", destination: "$HOME/flake.nix"
  config.vm.provision "file", source: "./hardware", destination: "$HOME/hardware"
  config.vm.provision "file", source: "./machine", destination: "$HOME/machine"

  config.vm.provision "shell",
    inline: "sudo nixos-rebuild switch --flake /home/vagrant#vagrant-libvirt"
end
