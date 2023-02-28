{ lib, ... }: {
  hardware.pulseaudio.enable = false;

  networking = {
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = lib.mkDefault true;
  };

  programs.dconf.enable = lib.mkDefault true;

  services = {
    # FIXME: Installing flatpak requires manually adding a repo
    # $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # FIXME: Flatpaks can't use old GTK3 themes from XDG_CONFIG without intervention
    # $ sudo flatpak override --filesystem=xdg-config/gtk-3.0
    flatpak.enable = lib.mkDefault true;

    pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
    };

    xserver = {
      enable = lib.mkDefault true;
      libinput = {
        enable = lib.mkDefault true;
        touchpad = {
          disableWhileTyping = lib.mkDefault true;
          naturalScrolling = lib.mkDefault true;
          tapping = lib.mkDefault true;
        };
      };
    };
  };

  xdg.portal.enable = lib.mkDefault true;
}
