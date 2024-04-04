{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    # TODO: figure out why none of this seems to apply
    gtk3 = {
      extraConfig = {
        gtk-cursor-blink = false;
        gtk-key-theme-name = "Emacs";
      };

      extraCss = ''
        .titlebar, window {
          border-radius: 0;
          box-shadow: none;
        }

        decoration {
          box-shadow: none;
        }

        decoration:backdrop {
          box-shadow: none;
        }
      '';
    };

    theme = {
      package = pkgs.orchis;
      name = "Orchis-Dark-Compact";
    };
  };

  home.pointerCursor.gtk.enable = true;

  wayland.windowManager.sway.wrapperFeatures.gtk = true;

  services.darkman =
    let
      themeScript = theme: ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-${theme}'"
      '';
    in
    {
      lightModeScripts.gtk = themeScript "light";
      darkModeScripts.gtk = themeScript "dark";
    };

  # ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme prefer-dark

  # xdg.systemDirs.data = [
  #   "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  # ];
}
