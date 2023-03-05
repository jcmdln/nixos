{ ... }: {
  home = {
    stateVersion = "22.11";
    homeDirectory = "/home/vagrant";
    username = "vagrant";
  };

  programs = {
    tmux = {
      enable = true;
      historyLimit = 8192;
      terminal = "xterm256-color";
    };
  };
}
