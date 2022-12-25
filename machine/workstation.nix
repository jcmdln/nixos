# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    vscode
  ];

  networking.hostname = "workstation";
  services.fwupd.enable = true;
}
