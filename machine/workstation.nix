# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [
    ./common.nix
    ../desktop/gnome.nix
    ../hardware/cpu/amd-kvm.nix
    ../hardware/storage/nvme.nix
  ];

  environment.systemPackages = with pkgs; [ vscode ];
  networking.hostName = "workstation";
}
