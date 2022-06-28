{
  programs.alacritty = {
    enable = true;

    settings = {
      font.size = 9;

      window.padding = {
        x = 8;
        y = 8;
      };

      import = [
        "~/.config/alacritty/theme.yaml"
      ];
    };
  };

  themes.scripts.alacritty = ''
    case "$THEME" in
      dark) ln -sf ${./dark-theme.yaml} ~/.config/alacritty/theme.yaml ;;
      light) ln -sf ${./light-theme.yaml} ~/.config/alacritty/theme.yaml ;;
    esac
  '';
}
