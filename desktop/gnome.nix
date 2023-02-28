{ lib, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [ gnome.gnome-tweaks ];

  # Allow port 3389 for GNOME Remote Desktop
  networking.firewall.allowedTCPPorts = [ 3389 ];

  services = {
    gnome.gnome-remote-desktop.enable = lib.mkDefault true;
    xserver = {
      desktopManager.gnome.enable = lib.mkDefault true;
      displayManager.gdm.enable = lib.mkDefault true;
    };
  };
}
