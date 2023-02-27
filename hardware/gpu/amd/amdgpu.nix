{ lib, pkgs }: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";

  hardware.opengl = {
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];

    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };

  services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" ];
}
