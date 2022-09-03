{ pkgs, ... }:

{
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [ swaylock ];
    };

    xwayland.enable = false;
  };
}
