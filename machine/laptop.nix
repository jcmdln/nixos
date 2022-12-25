# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    vscode
  ];

  networking.hostname = "laptop";
  services.fwupd.enable = true;
}
