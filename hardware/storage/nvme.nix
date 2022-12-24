# SPDX-License-Identifier: ISC

{ config, ... }: {
  boot.initrd.availableKernelModules = [ "nvme" ];
}
