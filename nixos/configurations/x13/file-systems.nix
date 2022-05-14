{
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/76BC-694B";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/96bd5221-9fe6-4bcc-9b21-91b1f539fc0a";
      fsType = "btrfs";
      options = [ "subvol=nixos" ];
    };
  };
}
