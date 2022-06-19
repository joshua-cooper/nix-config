{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  pinentry.curses.enable = true;
}
