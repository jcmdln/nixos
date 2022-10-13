# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "workstation";

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  services = {
    flatpak.enable = true;
    pipewire.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        plasma5.enable = true;
        sddm.enable = true;
      };
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
