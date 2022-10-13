# SPDX-License-Identifier: ISC
{
  description = "NixOS by jcmdln";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = "https://nix-community.cachix.org";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      # "laptop" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [ ./machine/workstation.nix ];
      # };

      # "server" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [ ./machine/server.nix ];
      # };

      "vagrant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machine/vagrant.nix ];
      };

      # "workstation" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [ ./machine/workstation.nix ];
      # };
    };
  };
}
