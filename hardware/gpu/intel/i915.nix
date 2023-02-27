{ config, lib, pkgs }: {
  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vaapiIntel
  ];
}
