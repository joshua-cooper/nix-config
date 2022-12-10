final: prev:

{
  zfs-backup = prev.writeShellScriptBin "zfs-backup" ''
    set -eu

    source_dataset=$1
    target_dataset=$2
    source_proxy_command=''${source_proxy_command:-}
    target_proxy_command=''${target_proxy_command:-}

    latest_source_snapshot=$($source_proxy_command zfs list -H -t snapshot "$source_dataset" | tail -n 1 | cut -d '	' -f 1 | cut -d @ -f 2)
    latest_target_snapshot=$($target_proxy_command zfs list -H -t snapshot "$target_dataset" | tail -n 1 | cut -d '	' -f 1 | cut -d @ -f 2)

    if [ -z "$latest_source_snapshot" ]; then
      printf 'error: no snapshots found for %s\n' "$source_dataset"
      exit 1
    fi

    if [ "$latest_target_snapshot" = "$latest_source_snapshot" ]; then
      printf "up to date\n"
      exit
    fi

    if zfs list "$source_dataset"@"$latest_target_snapshot" >/dev/null 2>&1; then
      $source_proxy_command zfs send -Rvw -I "$source_dataset"@"$latest_target_snapshot" "$source_dataset"@"$latest_source_snapshot" |
        $target_proxy_command zfs recv -v "$target_dataset"
    else
      $source_proxy_command zfs send -Rvw "$source_dataset"@"$latest_source_snapshot" |
        $target_proxy_command zfs recv -v "$target_dataset"
    fi
  '';
}
