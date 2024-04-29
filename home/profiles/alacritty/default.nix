{ config, lib, pkgs, ... }:

let
  tomlFormat = pkgs.formats.toml { };

  overrideThemePath = "${config.xdg.configHome}/alacritty/override-theme.toml";

  darkTheme = {
    colors = {
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
  };

  lightTheme = {
    colors = {
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
  };

  updateScript = theme: ''
    ln -sf ${tomlFormat.generate "override-theme.toml" theme} "${overrideThemePath}"
  '';
in

{
  programs.alacritty = {
    enable = true;
    settings = {
      # import = [
      #   (tomlFormat.generate "default-theme.toml" darkTheme)
      #   overrideThemePath
      # ];

      font = {
        size = 7;
        normal = {
          family = "Rec Mono Casual";
        };
      };

      window.padding = {
        x = 8;
        y = 8;
      };

      colors = darkTheme.colors;
    };
  };

  # services.darkman = {
  #   lightModeScripts.alacritty = updateScript lightTheme;
  #   darkModeScripts.alacritty = updateScript darkTheme;
  # };
  #
  # # Create the override theme file so Alacritty will watch it for changes.
  # home.activation.alacritty-override-theme = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   [ ! -f  ${overrideThemePath} ] && run touch ${overrideThemePath}
  # '';
}
