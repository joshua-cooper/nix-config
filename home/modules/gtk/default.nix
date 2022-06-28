{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig.gtk-key-theme-name = "Emacs";
  };

  wayland.windowManager.sway.wrapperFeatures.gtk = true;

  themes.scripts.gtk = ''
    case "$THEME" in
      dark) exec ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark ;;
      light) exec ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme Adwaita-light ;;
    esac
  '';
}
