{ pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = (with pkgs; [ vscode ]);
  networking.hostName = "workstation";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
