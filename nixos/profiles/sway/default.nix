{ pkgs, ... }:

{
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [ swaylock ];
    };

    xwayland.enable = false;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
