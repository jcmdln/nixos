# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "server";

  environment.systemPackages = with pkgs; [
    bpftrace
  ];

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
