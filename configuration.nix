# SPDX-License-Identifier: ISC

{ config, pkgs, nixpkgs, ... }: with config; {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.05";
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
    tmux
    wget

    ## Compilation
    # autoconf
    # autotools
    # clang_14
    # clang-analyzer
    # clang-tools_14
    # cmake
    # meson
    # mold
    # musl
    # pkg-config
    # samurai

    ## Golang
    # delve
    # go_1_18
    # go-tools
    # gopls

    ## Python
    # python310
    # python310Packages.pip
    # python310Packages.pipx
    # python310Packages.virtualenv

    ## Rust
    # cargo
    # clippy
    # rust-analyzer
    # rustc
    # rustfmt
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

  # virtualisation = {
  #   libvirtd.enable = true;
  #   podman = {
  #     enable = true;
  #     dockerCompat = true;
  #   };
  # };

  zramSwap = {
    enable = true;
    memoryMax = 4 * 1024 * 1024 * 1024; # 4GiB
    memoryPercent = 40;
  };
}
