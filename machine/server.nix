# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

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
