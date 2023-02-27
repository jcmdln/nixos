{
  description = "NixOS by jcmdln";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, ... }: {
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./desktop/gnome.nix
          ./devices/framework/intel-11th-gen.nix
          ./user/john.nix
        ] ++ [
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
        modules = [
          ./devices/vagrant.nix
          ./hardware/storage/nvme.nix
          ./user/vagrant.nix
        ] ++ [
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
          ./devices/workstation.nix
          ./hardware/cpu/amd.nix
          ./hardware/gpu/amd/amdgpu.nix
          ./hardware/storage/nvme.nix
        ] ++ [
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
