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
}
