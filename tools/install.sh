#!/usr/bin/env sh
# SPDX-License-Identifier: ISC
#
# This install script is for provisioning hardware/desktop-generic-amd.nix but
# can be used as a reference for other scenarios.

set -ex -o pipefail

# Create a GPT partition table
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme1n1 -- mklabel gpt

# Create and format /boot partition
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 1GiB
parted /dev/nvme0n1 -- set 1 esp on
mkfs.fat -F 32 -n boot /dev/nvme0n1p1

# Create and format btrfs partitions
parted nvme0n1 -- mkpart primary 1GiB -1MiB
parted nvme1n1 -- mkpart primary 1GiB -1MiB
mkfs.btrfs -L nixos -d raid0 -m raid1 /dev/nvme0n1p2 /dev/nvme1n1p1

# Create btrfs subvolumes
mount -t btrfs /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt

# Mount partitions
mount -o compress=zstd,subvol=root /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/{boot,home,nix}
mount /dev/disk/by-label/boot /mnt/boot
mkdir -p /mnt/boot/efi
mount -o compress=zstd,subvol=home /dev/disk/by-label/nixos /mnt/home
mount -o noatime,compress=zstd,subvol=nix /dev/disk/by-label/nixos /mnt/nix

# Clone NixOS config
nix-env -iA nixos.git
git clone https://github.com/jcmdln/nixos /mnt/etc/nixos

# Install NixOS, skipping prompt for root password
nixos-install --no-root-passwd \
    --flake /mnt/etc/nixos#vagrant-libvirt \
    --root /mnt

# Cleanup any garbage we may have accumulated
nix-collect-garbage -d
