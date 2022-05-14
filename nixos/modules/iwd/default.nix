{ pkgs, ... }:

{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings.AlwaysRandomizeAddress = true;
    };
  };

  systemd.services.iwd = {
    serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
  };
}
