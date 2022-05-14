{ lib, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; lib.optionals pkgs.stdenv.isLinux [ mpris ];
  };
}
