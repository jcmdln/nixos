# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [
    ./common.nix
    ../desktop/gnome.nix
    ../hardware/storage/nvme.nix
    ../user/john.nix
  ];

  environment.systemPackages = with pkgs; [ vscode ];
  networking.hostName = "workstation";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
