# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    gparted
    nix-prefetch-scripts
    wget
    vim
    tmux
  ];

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager-openvpn ];
    };

    useDHCP = false; # Deprecated, explicitly set to false
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;
    sway.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    gvfs.enable = true;
    printing.enable = true;
    sshd.enable = true;
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  time.timeZone = "US/Eastern";

  users.users.john = {
    createHome = true;
    extraGroups = [ "libvirtd" "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ ];
    uid = 1000;
  };

  virtualisation = {
    libvirtd = { enable = false; };

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  zramSwap = {
    enable = true;
    # Ensure we don't exceed a 4GiB swap
    memoryMax = 4294967296;
    # Use 25% of available system memory
    memoryPercent = 25;
  };
}
