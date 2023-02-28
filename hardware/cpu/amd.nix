{ config, lib, ... }:
let kver = config.boot.kernelPackages.kernel.version; in
{
  # https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
  boot = lib.mkMerge [
    (lib.mkIf ((lib.versionAtLeast kver "5.17") && (lib.versionOlder kver "6.1")) {
      kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
      kernelModules = [ "amd-pstate" ];
    })
    (lib.mkIf (lib.versionAtLeast kver "6.1") {
      kernelParams = [ "amd_pstate=passive" ];
    })
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
