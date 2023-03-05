{ pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [ gnome.gnome-tweaks ];

  # Allow port 3389 for GNOME Remote Desktop
  networking.firewall.allowedTCPPorts = [ 3389 ];

  services = {
    gnome.gnome-remote-desktop.enable = true;
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
