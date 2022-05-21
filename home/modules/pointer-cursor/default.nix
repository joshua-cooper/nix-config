{ config, pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.gnome-themes-extra;
    name = "Adwaita";
    size = 20;
    gtk.enable = config.gtk.enable;
  };
}
