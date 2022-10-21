# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./server.nix ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  programs.dconf.enable = true;

  services = {
    flatpak.enable = true;
    pipewire.enable = true;

    xserver = {
      enable = true;
      displayManager = {
        plasma5.enable = true;
        sddm.enable = true;
      };

      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
          tapping = true;
        };
      };
    };
  };
}
