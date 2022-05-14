{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [ swaylock ];
  };

  programs.xwayland.enable = false;
}
