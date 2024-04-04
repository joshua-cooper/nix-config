# Wrap darkman to add bash to its path. A later version of darkman no longer
# implicitly calls bash, so this can be removed.

final: prev:

let
  wrapped = final.writeShellApplication {
    name = "darkman";
    runtimeInputs = with final; [ prev.darkman bash coreutils ];
    text = ''
      exec darkman "$@"
    '';
  };
in

{
  darkman = final.symlinkJoin {
    name = "darkman";
    paths = [
      wrapped
      prev.darkman
    ];
  };
}
