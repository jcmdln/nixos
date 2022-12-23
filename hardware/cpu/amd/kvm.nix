# SPDX-License-Identifier: ISC

{ config, lib, ... }: {
  boot.kernelModules = [ "kvm-amd" ];
}
