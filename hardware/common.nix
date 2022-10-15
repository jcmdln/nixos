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

  networking.useDHCP = lib.mkDefault true;
}
