# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_5_15;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bpftrace
    btrfs-progs
    curl
    dig
    git
    inetutils
    nix-prefetch-scripts
    podman
    tmux
    wget

    # delve
    # go_1_18
    # go-tools
    # golsp

    # python310
    # python310Packages.pip
    # python310Packages.pipx
    # python310Packages.virtualenv

    # cargo
    # clippy
    # rust-analyzer
    # rustc
    # rustfmt
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  networking.hostName = "nixos";

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mtr.enable = true;
  };

  security.rtkit.enable = true;
  services.openssh.enable = true;
  time.timeZone = "US/Eastern";

  virtualisation = {
    libvirtd.enable = false;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryMax = 4 * 1024 * 1024 * 1024; # 4GiB
    memoryPercent = 40;
  };
}
