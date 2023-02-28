{ lib, ... }: {
  imports = [ ./common.nix ];

  services.xserver = {
    desktopManager.plasma5.enable = lib.mkDefault true;
    displayManager.sddm.enable = lib.mkDefault true;
  };
}
