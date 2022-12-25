# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [
    ./common.nix
    ../desktop/gnome.nix
    ../hardware/cpu/intel-kvm.nix
    ../hardware/storage/nvme.nix
    ../user/john.nix
  ];

  environment.systemPackages = with pkgs; [ vscode ];
  networking.hostName = "laptop";
}
