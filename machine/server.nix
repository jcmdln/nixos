# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  networking.hostname = "server";
  services.fwupd.enable = true;
}
