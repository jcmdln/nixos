{ pkgs, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "server";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
