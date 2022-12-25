# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [
    ./common.nix
    ../users/vagrant.nix
  ];

  environment.systemPackages = with pkgs; [
    gnused
  ];

  networking.hostName = "nixos";
}
