# SPDX-License-Identifier: ISC

{
  description = "NixOS by jcmdln";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixos-hardware, nixpkgs }: {
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = (with nixos-hardware.nixosModules; [
          framework
        ]) ++ ([
          ./desktop/gnome.nix
          ./hardware/cpu/intel-kvm.nix
          ./hardware/storage/nvme.nix
          ./machine/laptop.nix
          ./users/john.nix
        ]);
      };

      "vagrant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/cpu/qemu64.nix
          ./machine/vagrant.nix
        ];
      };

      "workstation" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = (with nixos-hardware.nixosModules; [
          common-cpu-amd
          common-cpu-amd-pstate
          common-gpu-amd
        ]) ++ ([
          ./desktop/gnome.nix
          ./hardware/cpu/amd-kvm.nix
          ./hardware/storage/nvme.nix
          ./machine/workstation.nix
          ./users/john.nix
        ]);
      };
    };
  };
}
