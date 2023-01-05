# SPDX-License-Identifier: ISC

{
  description = "NixOS by jcmdln";

  inputs = {
    nixpkgs.url = "github:jcmdln/nixpkgs/release-22.11";
    nixos-hardware.url = "github:jcmdln/nixos-hardware/common-cpu-kvm";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixos-hardware, nixpkgs, ... }: {
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machine/laptop.nix
        ] ++ (with nixos-hardware.nixosModules; [
          framework
        ]) ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."john" = import ./home/john.nix;
          }
        ];
      };

      "vagrant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machine/vagrant.nix ] ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."vagrant" = import ./home/vagrant.nix;
          }
        ];
      };

      "workstation" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machine/workstation.nix
        ] ++ (with nixos-hardware.nixosModules; [
          common-cpu-amd
          common-cpu-amd-pstate
          common-gpu-amd
        ]) ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."john" = import ./home/john.nix;
          }
        ];
      };
    };
  };
}
