{ lib, ... }: {
  home = {
    stateVersion = "22.11";
    homeDirectory = "/home/john";
    username = "john";
  };

  programs = {
    tmux = {
      enable = lib.mkDefault true;
      historyLimit = 8192;
      terminal = "xterm256-color";
    };
  };
}
