{ lib, ... }: {
  boot.initrd.availableKernelModules = [ "nvme" ];
  services.fstrim.enable = lib.mkDefault true;
}
