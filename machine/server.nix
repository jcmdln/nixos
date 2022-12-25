# SPDX-License-Identifier: ISC

{ config, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "server";
  services.fwupd.enable = true;
}
