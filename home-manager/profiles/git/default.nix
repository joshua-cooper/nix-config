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
}
