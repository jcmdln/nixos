# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    htop
    iftop
    iotop
    lm_sensors
    pciutils
    usbutils
  ];

  networking.hostName = "server";
  services.fwupd.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
