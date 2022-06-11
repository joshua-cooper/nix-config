{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ swaylock ];

  xdg.configFile."swaylock/config".text = ''
    image=${config.xdg.dataHome}/wallpaper
    color=000000
    scaling=fill
    no-unlock-indicator
  '';
}
