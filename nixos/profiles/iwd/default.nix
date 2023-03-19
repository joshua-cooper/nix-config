{ pkgs, ... }:

{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General.AddressRandomization = "network";
      Settings.AlwaysRandomizeAddress = true;
    };
  };

  systemd.services.iwd = {
    serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
  };

  state.directories = [
    { directory = "/var/lib/iwd"; mode = "0700"; }
  ];
}
