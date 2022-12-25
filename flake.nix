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
          ./desktop/gnome.nix
          ./hardware/cpu/amd-kvm.nix
          ./hardware/storage/nvme.nix
          ./machine/workstation.nix
        ];
      };

      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.framework
          ./desktop/gnome.nix
          ./hardware/cpu/intel-kvm.nix
          ./hardware/storage/nvme.nix
          ./machine/laptop.nix
        ];
      };

      "vagrant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/cpu/qemu64.nix
          ./machine/vagrant.nix
        ];
      };
    };
  };
}
