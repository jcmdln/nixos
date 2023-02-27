{ lib, pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = (with pkgs; [ vscode ]);
  networking.hostName = "workstation";

  virtualisation.libvirtd = {
    enable = lib.mkDefault true;
    qemu = {
      ovmf.enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.qemu_kvm;
      swtpm.enable = lib.mkDefault true;
    };
  };
}
