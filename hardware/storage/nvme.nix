{ ... }: {
  boot.initrd.availableKernelModules = [ "nvme" ];
  services.fstrim.enable = true;
}
