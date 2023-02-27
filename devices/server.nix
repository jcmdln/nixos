{ lib, pkgs, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "server";

  virtualisation.libvirtd = {
    enable = lib.mkDefault true;
    qemu = {
      ovmf.enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.qemu_kvm;
      swtpm.enable = lib.mkDefault true;
    };
  };
}
