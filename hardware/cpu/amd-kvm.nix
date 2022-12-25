# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  boot.kernelModules = [ "kvm-amd" ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
