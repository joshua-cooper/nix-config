{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "mode=755" "size=16G" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

    "/nix" = {
      device = "x13/nix";
      fsType = "zfs";
    };

    "/state" = {
      device = "x13/state";
      fsType = "zfs";
      neededForBoot = true;
    };
  };
}
