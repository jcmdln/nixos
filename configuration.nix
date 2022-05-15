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
    libvirt
    mg
    nix-prefetch-scripts
    tmux
    vscode
    wget
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    spleen
  ];

  networking = {
    hostName = "nixos";
    useDHCP = false; # Deprecated, explicitly set to false
  };

  programs = {
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak.enable = true;
    gvfs.enable = true;
    openssh.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = false;
      media-session.enable = false;
      pulse.enable = true;
    };

    printing.enable = true;

    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

  };

  sound = {
    enable = false;
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
