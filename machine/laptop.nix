# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    vscode
  ];

  networking.hostName = "laptop";
  services.fwupd.enable = true;
}
