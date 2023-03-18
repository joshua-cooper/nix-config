{ pkgs, ... }:

{
  imports = [
    ../../profiles/base
    ../../profiles/git
    ../../profiles/neovim
    ../../profiles/tmux
  ];

  home = rec {
    username = "codespace";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    packages = with pkgs; [ home-manager ];
  };
}
