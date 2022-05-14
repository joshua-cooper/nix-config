{
  programs.git = {
    enable = true;
    userName = "Josh Cooper";
    userEmail = "josh@cooper.dev";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
    };
  };
}
