{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig.gtk-key-theme-name = "Emacs";
  };
}
