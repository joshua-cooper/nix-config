{ pkgs, ... }:

{
  imports = [ ../pass ];

  home.packages = with pkgs; [ pass-menu ];
}
