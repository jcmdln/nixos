# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ../common.nix ];

  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
}
