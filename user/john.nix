{ ... }: {
  security.sudo.extraRules = [{
    users = [ "john" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  users.users."john" = {
    createHome = true;
    extraGroups = [ "libvirt" "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTO2nxnuc/nJBeMpi0rm+6PbDu9jl04576jRf7qgMpk"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4qKrTnTWdbNQHrvf5wdx24UuNvGkeGBHDNC6Z3d10S"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIOtyoTumvN+Qyq+lzUbYmkjSxltderxQNv+3jGuIHlM"
    ];
  };
}
