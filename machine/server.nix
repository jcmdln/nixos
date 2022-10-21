# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [ htop iftop iotop lm_sensors ];

  services.fwupd.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
