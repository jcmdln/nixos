# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ../common.nix ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];

  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
}
