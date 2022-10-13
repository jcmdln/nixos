# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
  imports = [ ../hardware-configuration.nix ];

  networking.hostName = "nixos";
  system.stateVersion = "22.05";
  time.timeZone = "US/Eastern";

  boot = {
    kernelPackages = pkgs.linuxPackages_5_15;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs
    curl
    dig
    emacs-nox
    inetutils
    gnused
    unzip
    wget
  ];

  programs = {
    dconf.enable = true;
    gnupg.agent.enable = true;
    mtr.enable = true;
  };

  security.rtkit.enable = true;
  services = {
    dbus.enable = true;
    openssh.enable = true;
    resolved.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryMax = 4 * 1024 * 1024 * 1024; # 4GiB
    memoryPercent = 40;
  };
}
