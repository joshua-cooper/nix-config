{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    # TODO: XCURSOR_SIZE isn't following this (just uses 24 by default)
    # Need to find where that is being set so this can be changed.
    size = 24;
  };
}
