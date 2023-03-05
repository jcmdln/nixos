{ pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = (with pkgs; [ vscode ]);
  networking.hostName = "laptop";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
