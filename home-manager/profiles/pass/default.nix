{ config, pkgs, ... }:

{
  home = {
    sessionVariables.PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    # TODO: Make a module to conditionally enable this since it pulls in bemenu.
    packages = with pkgs; [ pass-menu ];
  };

  programs.password-store = {
    enable = true;
  };
}
