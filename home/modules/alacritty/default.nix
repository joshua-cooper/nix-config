{ pkgs, ... }:

let
  darkTheme = {
    primary = {
      background = "#282828";
      foreground = "#ebdbb2";
    };

    normal = {
      black = "#282828";
      red = "#cc241d";
      green = "#98971a";
      yellow = "#d79921";
      blue = "#458588";
      magenta = "#b16286";
      cyan = "#689d6a";
      white = "#a89984";
    };

    bright = {
      black = "#928374";
      red = "#fb4934";
      green = "#b8bb26";
      yellow = "#fabd2f";
      blue = "#83a598";
      magenta = "#d3869b";
      cyan = "#8ec07c";
      white = "#ebdbb2";
    };
  };

  lightTheme = {
    primary = {
      background = "#fbf1c7";
      foreground = "#3c3836";
    };

    normal = {
      black = "#fbf1c7";
      red = "#cc241d";
      green = "#98971a";
      yellow = "#d79921";
      blue = "#458588";
      magenta = "#b16286";
      cyan = "#689d6a";
      white = "#7c6f64";
    };

    bright = {
      black = "#928374";
      red = "#9d0006";
      green = "#79740e";
      yellow = "#b57614";
      blue = "#076678";
      magenta = "#8f3f71";
      cyan = "#427b58";
      white = "#3c3836";
    };
  };

  darkThemeYaml = pkgs.writeText "alacritty-dark-theme.yaml" (builtins.toJSON { colors = darkTheme; });

  lightThemeYaml = pkgs.writeText "alacritty-light-theme.yaml" (builtins.toJSON { colors = lightTheme; });
in
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
      dark) ln -sf ${darkThemeYaml} ~/.config/alacritty/theme.yaml ;;
      light) ln -sf ${lightThemeYaml} ~/.config/alacritty/theme.yaml ;;
    esac
  '';
}
