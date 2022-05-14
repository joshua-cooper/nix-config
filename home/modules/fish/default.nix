{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_color_host_remote "$fish_color_host"
    '';

    shellAbbrs = {
      g = "git";
      gs = "git status";
      gd = "git diff";
      gl = "git log";
      gf = "git fetch";
      gb = "git branch";
      gr = "git rebase";
      gp = "git push origin HEAD";
      gco = "git checkout";
    };
  };
}
