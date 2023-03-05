final: prev:

let
  quote = p: "\"${(prev.lib.escape ["\\" "\""] p)}\"";
  ro-bind = path: "--ro-bind ${quote path} ${quote path}";
  bind = path: "--bind ${quote path} ${quote path}";
  dev-bind = path: "--dev-bind ${quote path} ${quote path}";
  setenv = name: value: "--setenv ${quote name} ${quote value}";

  args = [
    "--unshare-all"
    "--share-net"
    "--die-with-parent"
    "--dev /dev"
    (dev-bind "/dev/pts") # Needed for pinentry-curses to work
    "--proc /proc"
    "--tmpfs /tmp"
    (ro-bind "/nix")
    (ro-bind "/run/current-system/sw/bin")
    (ro-bind "/etc/profiles/per-user/$USER")
    (ro-bind "/etc/static/profiles/per-user/$USER")
    (ro-bind "/etc/nix/nix.conf")
    (ro-bind "/etc/passwd")
    (ro-bind "/etc/group")
    (ro-bind "/etc/resolv.conf")
    (ro-bind "/etc/static/resolv.conf")
    (ro-bind "/etc/ssl/certs")
    (ro-bind "/etc/static/ssl/certs")
    (ro-bind "$XDG_RUNTIME_DIR/gnupg")
    (ro-bind "$GNUPGHOME/gpg.conf")
    (ro-bind "$GNUPGHOME/pubring.kbx")
    (ro-bind "$GNUPGHOME/trustdb.gpg")
    (ro-bind "$XDG_CONFIG_HOME/nvim")
    (ro-bind "$XDG_CONFIG_HOME/fish")
    (bind "$PWD")
    (setenv "DEVBOX" "$PWD")
    (quote "$SHELL")
  ];
in
{
  devbox = prev.writeShellScriptBin "devbox" ''
    exec ${prev.bubblewrap}/bin/bwrap \
      ${prev.lib.concatStringsSep " \\\n  " args}
  '';
}
