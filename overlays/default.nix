final: prev:

let
  mkBemenuWrapper = command: ''
    XDG_CONFIG_HOME=''${XDG_CONFIG_HOME:-$HOME/.config}
    export BEMENU_OPTS="$(tr "\n" " " < "$XDG_CONFIG_HOME"/bemenu/config) $BEMENU_OPTS"
    exec ${command} "$@"
  '';
in
{
  bemenu = prev.symlinkJoin {
    name = "bemenu";
    paths = [
      (prev.writeShellScriptBin "bemenu" (mkBemenuWrapper "${prev.bemenu}/bin/bemenu"))
      (prev.writeShellScriptBin "bemenu-run" (mkBemenuWrapper "${prev.bemenu}/bin/bemenu-run"))
      prev.bemenu
    ];
  };

  pinentry-bemenu = prev.symlinkJoin {
    name = "pinentry-bemenu";
    paths = [
      (prev.writeShellScriptBin "pinentry-bemenu" (mkBemenuWrapper "${prev.pinentry-bemenu}/bin/pinentry-bemenu"))
      prev.pinentry-bemenu
    ];
  };
}
