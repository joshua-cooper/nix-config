{ pkgs, ... }:

let
  pinentry = pkgs.writeShellScriptBin "pinentry" ''
    set -eu

    case "$PINENTRY_USER_DATA" in
      bemenu) exec ${pkgs.pinentry-bemenu}/bin/pinentry-bemenu "$@" ;;
      curses) exec ${pkgs.pinentry-curses}/bin/pinentry-curses "$@" ;;
      *) exec ${pkgs.pinentry-curses}/bin/pinentry-curses "$@" ;;
    esac
  '';
in
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = null;
    extraConfig = ''
      pinentry-program ${pinentry}/bin/pinentry
    '';
  };
}
