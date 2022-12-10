{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.zfs-backup;
in
{
  options.services.zfs-backup = {
    enable = mkEnableOption "ZFS dataset backup service";
  };

  config = mkIf cfg.enable {
    users = {
      groups.zfs-backup = { };

      users.zfs-backup = {
        group = "zfs-backup";
        isSystemUser = true;
        home = "/var/lib/zfs-backup";
        createHome = false;
      };
    };

    systemd.services = {
      zfs-backup = {
        description = "ZFS backup from x13/state to data1/x13";
        after = [ "zfs.target" ];
        startAt = "hourly";
        path = with pkgs; [ zfs openssh ];
        serviceConfig = {
          Environment = "target_proxy_command='ssh -i /nix/passwords/backups_ed25519 root@zh2641b.rsync.net'";
          ExecStart = "${pkgs.zfs-backup}/bin/zfs-backup x13/state data1/x13";
          User = "zfs-backup";
          Group = "zfs-backup";
        };
      };
    };
  };
}
