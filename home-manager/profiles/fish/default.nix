{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_color_host_remote "$fish_color_host"
    '';
  };
}
