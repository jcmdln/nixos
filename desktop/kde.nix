# SPDX-License-Identifier: ISC

{ config, ... }: {
  imports = [ ./common.nix ];

  services.xserver = {
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };
}
