{ pkgs, ... }: {
  imports = [ ./common.nix ];

  environment.systemPackages = (with pkgs; [ vscode ]);
  networking.hostName = "laptop";

  services.logind.lidSwitchExternalPower = "ignore";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
}
