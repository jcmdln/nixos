{ lib, pkgs, ... }: {
  imports = [ ../hardware/common.nix ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = "https://nix-community.cachix.org";
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  system.stateVersion = "22.11";
  time.timeZone = lib.mkDefault "US/Eastern";

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_6_1;
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      systemd-boot.enable = lib.mkDefault true;
    };
  };

  environment.systemPackages = (with pkgs; [
    bpftrace
    btrfs-progs
    dig
    git
    htop
    iftop
    inetutils
    iotop
    lm_sensors
    pciutils
    usbutils
  ]);

  networking = {
    networkmanager.enable = lib.mkDefault true;
  };

  programs = {
    gnupg.agent.enable = lib.mkDefault true;
    mtr.enable = lib.mkDefault true;
  };

  security.rtkit.enable = lib.mkDefault true;

  services = {
    dbus.enable = lib.mkDefault true;
    fwupd.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault true;
    resolved = {
      enable = lib.mkDefault true;
      dnssec = lib.mkDefault "false";
      llmnr = lib.mkDefault "false";
    };
  };

  virtualisation.podman = {
    enable = lib.mkDefault true;
    dockerCompat = lib.mkDefault true;
  };

  zramSwap = {
    enable = lib.mkDefault true;
    memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
    memoryPercent = 25;
  };
}
