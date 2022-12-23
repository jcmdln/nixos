# SPDX-License-Identifier: ISC

{ config, lib, ... }: {
  boot.initrd.availableKernelModules = [ "nvme" ];
}
