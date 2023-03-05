{ pkgs, ... }: {
  imports = [ ../hardware/common.nix ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.11";
  time.timeZone = "US/Eastern";

  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
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
    networkmanager.enable = true;
  };

  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    dbus.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
      llmnr = "false";
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  zramSwap = {
    enable = true;
    memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
    memoryPercent = 25;
  };
}
