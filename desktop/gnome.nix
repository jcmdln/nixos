# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];

  networking.firewall.allowedTCPPorts = [ 3389 ];

  services = {
    gnome.gnome-remote-desktop.enable = true;
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
