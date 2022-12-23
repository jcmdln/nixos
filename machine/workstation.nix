# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./server.nix ];

  environment = {
    systemPackages = with pkgs; [
      libsForQt5.breeze-gtk
      vscode
    ];
  };

  networking = {
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };
}
