{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ swaylock ];

  xdg.configFile."swaylock/config".text = ''
    image=${config.xdg.dataHome}/wallpaper
    scaling=fill
    no-unlock-indicator
  '';
}
