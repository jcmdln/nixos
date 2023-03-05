{ pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.variables.AMD_VULKAN_ICD = "RADV";

  hardware.opengl = {
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];

    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
