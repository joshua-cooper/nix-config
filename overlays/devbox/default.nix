final: prev:

{
  devbox = prev.writeShellScriptBin "devbox" ''
    ${prev.bubblewrap}/bin/bwrap \
      --unshare-all \
      --share-net \
      --die-with-parent \
      --dev /dev \
      --proc /proc \
      --tmpfs /tmp \
      --ro-bind /nix /nix \
      --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
      --ro-bind "/etc/profiles/per-user/$USER" "/etc/profiles/per-user/$USER" \
      --ro-bind "/etc/static/profiles/per-user/$USER" "/etc/static/profiles/per-user/$USER" \
      --ro-bind /etc/nix/nix.conf /etc/nix/nix.conf \
      --ro-bind /etc/passwd /etc/passwd \
      --ro-bind /etc/group /etc/group \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --ro-bind /etc/static/resolv.conf /etc/static/resolv.conf \
      --ro-bind /etc/ssl/certs /etc/ssl/certs \
      --ro-bind /etc/static/ssl/certs /etc/static/ssl/certs \
      --ro-bind "$XDG_CONFIG_HOME/nvim" "$XDG_CONFIG_HOME/nvim" \
      --ro-bind "$XDG_CONFIG_HOME/fish" "$XDG_CONFIG_HOME/fish" \
      --ro-bind "$GNUPGHOME" "$GNUPGHOME" \
      --bind "$PWD" "$PWD" \
      --setenv DEVBOX "$PWD" \
      "$SHELL"
  '';
}
