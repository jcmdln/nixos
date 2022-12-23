# SPDX-License-Identifier: ISC
{
  description = "NixOS by jcmdln";

  inputs = {
    #home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
  };

  outputs = { self, nixos-hardware, nixpkgs }: {
    nixosConfigurations = {
      "workstation" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-gpu-amd
          ./desktop/gnome/default.nix
          ./hardware/common.nix
          ./hardware/cpu/amd/kvm.nix
          ./hardware/nvme/default.nix
          ./machine/workstation.nix
        ];
      };

      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.framework
          ./desktop/gnome/default.nix
          ./hardware/common.nix
          ./hardware/cpu/intel/kvm.nix
          ./hardware/nvme/default.nix
          ./machine/laptop.nix
        ];
      };

      "vagrant-libvirt" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/common.nix
          ./hardware/cpu/qemu/default.nix
          ./machine/vagrant.nix
        ];
      };
    };
  };
}
