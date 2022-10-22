# SPDX-License-Identifier: ISC

{ config, lib, ... }: {
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
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "noatime" "compress=zstd" "subvol=nix" ];
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
