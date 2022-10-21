# SPDX-License-Identifier: ISC

{ config, lib, ... }: {
  imports = [ ./common.nix ];

  boot.initrd = {
    availableKernelModules = [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];
    kernelModules = [ "kvm-amd" ];
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
  };
}
