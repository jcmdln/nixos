# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  programs.dconf.enable = true;

  networking = {
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  services = {
    # FIXME: Installing flatpak requires manually adding a repo
    # $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # FIXME: Flatpaks can't use old GTK3 themes from XDG_CONFIG without intervention
    # $ sudo flatpak override --filesystem=xdg-config/gtk-3.0
    flatpak.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    xdg.portal.enable = true;

    xserver = {
      enable = true;
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