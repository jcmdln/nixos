# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [
    ./common.nix
    ../hardware/cpu/qemu64.nix
    ../user/vagrant.nix
  ];

  environment.systemPackages = with pkgs; [ gnused ];
  networking.hostName = "wewlad";
}
