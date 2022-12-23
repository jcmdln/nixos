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
    c.vm.box_version = "22.11"
  end

  ["flake.lock", "flake.nix", "hardware", "machine"].each do |file|
    config.vm.provision "file", source: "./#{file}", destination: "$HOME/#{file}"
  end

  config.vm.provision "shell" do |sh|
    sh.privileged = true
    sh.inline = %Q{
      set -ex
      nixos-rebuild switch --flake /home/vagrant#vagrant-libvirt
      nix-collect-garbage -d
    }
  end
end
