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

  mosh = prev.mosh.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        # truecolor
        url = "https://github.com/mobile-shell/mosh/commit/ac0492cb5a703ae979b5c923182671d2688b025a.patch";
        sha256 = "sha256-bOA96fnutrFOAbAFDhMkeLJ/7ERL30m3FSCdU5GSh2o=";
      })
    ];
  });
}
