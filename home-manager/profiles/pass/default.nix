{ config, ... }:

{
  home.sessionVariables.PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
  programs.password-store.enable = true;
}
