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
mv /mnt/etc/nixos/configuration.nix{,.backup}
curl -L -o /mnt/etc/nixos/configuration.nix \
    https://raw.githubusercontent.com/jcmdln/nixos/master/configuration.nix

# Install
nixos-install

# (Optional) Cleanup any garbage we may have accumulated
nix-collect-garbage -d

# Reboot into the new system
reboot
```

## Update

```sh
nix-channel --update &&
nixos-rebuild switch --upgrade &&
nix-collect-garbage -d
```

# Contributing

## Developing

If your editor supports LSP, consider installing the following utilities:

```sh
nix profile install \
    github:nix-community/nixpkgs-fmt \
    github:nix-community/rnix-lsp
```

# Special Thanks

-   https://github.com/nixos
-   https://github.com/nix-community
-   https://nixos.wiki/wiki/Flakes
-   https://github.com/mitchellh/nixos-config
