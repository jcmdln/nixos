# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./server.nix ];

  environment.systemPackages = with pkgs; [ libsForQt5.breeze-gtk ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  programs.dconf.enable = true;

  services = {
    # Errata: Flatpak requires extra steps
    # - flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # - sudo flatpak override --filesystem=xdg-config/gtk-3.0
    flatpak.enable = true;
    pipewire.enable = true;

    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
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
