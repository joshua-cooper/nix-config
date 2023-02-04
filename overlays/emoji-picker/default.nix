final: prev:

{
  emoji-picker = prev.writeShellScriptBin "emoji-picker" ''
    emoji=$(${prev.bemenu}/bin/bemenu < ${./emoji}| sed "s/ .*//")
    [ -z "$emoji" ] && exit 1
    ${prev.wtype}/bin/wtype "$emoji"
  '';
}
