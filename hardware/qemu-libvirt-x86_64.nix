# SPDX-License-Identifier: ISC

{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [ "ahci" "sd_mod" "sr_mod" "virtio_pci" "virtio_scsi" ];
      kernelModules = [ ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "noatime" "compress=zstd" "subvol=nix" ];
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;
  swapDevices = [ ];
}
