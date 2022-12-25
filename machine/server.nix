# SPDX-License-Identifier: ISC

{ config, ... }: {
  imports = [ ./common.nix ];

  networking.hostname = "server";
  services.fwupd.enable = true;
}
