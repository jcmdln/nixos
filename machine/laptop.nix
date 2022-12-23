# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./workstation.nix ];

  networking.hostName = "laptop";
}
