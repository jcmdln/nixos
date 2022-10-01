This repository is where I keep my NixOS notes and materials.

https://nixos.org/manual/nixos/stable/index.html

# Usage

## Install NixOS

```sh
# Create a GPT partition table
parted /dev/vda -- mklabel gpt

# Create and format /boot partition
parted /dev/vda -- mkpart ESP fat32 1MiB 1GiB
parted /dev/vda -- set 1 esp on
mkfs.fat -F 32 -n boot /dev/vda1

# Create and format btrfs partition
parted /dev/vda -- mkpart primary 1GiB -1MiB
mkfs.btrfs -L nixos /dev/vda2

# Create btrfs subvolumes
mount -t btrfs /dev/vda2 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt

# Mount partitions
mount -o compress=zstd,subvol=root /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/{boot,home,nix}
mount /dev/disk/by-label/boot /mnt/boot
mount -o compress=zstd,subvol=home /dev/disk/by-label/nixos /mnt/home
mount -o noatime,compress=zstd,subvol=nix /dev/disk/by-label/nixos /mnt/nix

# Configure NixOS
nixos-generate-config --root /mnt
nixos-install
reboot
```

## Update

```sh
nix-channel --update
nixos-rebuild switch --upgrade
nix-collect-garbage
```

# Contributing

## Developing

If your editor supports LSP, consider installing the following utilities:

```sh
nix --extra-experimental-features "nix-command flakes" profile install \
    github:nix-community/nixpkgs-fmt \
    github:nix-community/rnix-lsp
```
