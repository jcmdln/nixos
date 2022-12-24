# SPDX-License-Identifier: ISC

{ config, ... }: {
  boot.kernelModules = [ "kvm-intel" ];
}
