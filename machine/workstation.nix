# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    vscode
  ];

  networking.hostName = "workstation";
  services.fwupd.enable = true;
}
