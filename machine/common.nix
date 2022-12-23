# SPDX-License-Identifier: ISC

{ config, lib, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = "https://nix-community.cachix.org";
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bpftrace
    btrfs-progs
    dig
    git
    inetutils
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    dbus.enable = true;
    openssh.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
      llmnr = "false";
    };
  };

  system.stateVersion = "22.05";
  time.timeZone = "US/Eastern";

  zramSwap = {
    enable = true;
    memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
    memoryPercent = 25;
  };
}
