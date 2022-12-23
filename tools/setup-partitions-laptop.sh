#!/usr/bin/env sh
# SPDX-License-Identifier: ISC
#
# This script sets up partitions for a specfic device I own. Only use this as
# a reference, DO NOT use it verbatim!

set -ex -o pipefail

# Create a GPT partition table
parted /dev/nvme0n1 -- mklabel gpt

# Create and format /boot partition
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 1GiB
parted /dev/nvme0n1 -- set 1 esp on
mkfs.fat -F 32 -n boot /dev/nvme0n1p1

# Create and format btrfs partition
parted /dev/nvme0n1 -- mkpart primary 1GiB -1MiB
mkfs.btrfs -L nixos /dev/nvme0n1p2

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
