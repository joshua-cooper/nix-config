{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ swaylock ];

  programs.swaylock.settings = {
    image = "${config.xdg.dataHome}/wallpaper";
    color = "000000";
    scaling = "fill";
    no-unlock-indicator = true;
  };
}
