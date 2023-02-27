{ lib, pkgs, ... }: {
  imports = [
    ./common.nix

    ../hardware/cpu/qemu64.nix
  ];

  environment.systemPackages = (with pkgs; [ gnused ]);
  networking.hostName = "vagrant";
}
