{ ... }: {
  imports = [
    ../laptop.nix

    ../../hardware/cpu/intel.nix
    ../../hardware/gpu/intel/i915.nix
    ../../hardware/storage/nvme.nix
  ];
}
