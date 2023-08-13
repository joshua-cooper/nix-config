final: prev:

{
  start-sway = prev.writeShellScriptBin "start-sway" ''
    set -eu
    export PINENTRY_USER_DATA=gnome
    exec systemd-cat --identifier=sway ${prev.sway}/bin/sway "$@"
  '';
}
