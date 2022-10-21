# SPDX-License-Identifier: ISC

{ config, pkgs, ... }: {
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

  environment.systemPackages = with pkgs; [ bpftrace btrfs-progs dig inetutils ];

  programs = {
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
    memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
    memoryPercent = 33;
  };
}
