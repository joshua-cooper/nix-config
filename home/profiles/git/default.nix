{ lib, ... }:

{
  programs.git = {
    enable = true;
    userName = lib.mkDefault "Josh Cooper";
    userEmail = lib.mkDefault "josh@cooper.dev";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };
  };

  home.shellAliases = {
    g = "git";
    gs = "git status";
    gc = "git commit";
    gd = "git diff";
    gl = "git log";
    gf = "git fetch";
    gb = "git branch";
    gr = "git rebase";
    gco = "git checkout";
  };
}
