{ config, pkgs, ... }:

{
  home.sessionVariables.PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";

  programs.password-store = {
    enable = true;
    package = pkgs.pass-nodmenu.withExtensions (e: with e; [ pass-otp ]);
  };
}
