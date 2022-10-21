# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./server.nix ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  services = {
    dconf.enable = true;
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
