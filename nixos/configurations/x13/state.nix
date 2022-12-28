{
  environment.persistence."/state" = {
    directories = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      { directory = "/var/lib/iwd"; mode = "0700"; }
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/systemd/timesync/clock"
    ];

    users.josh = {
      directories = [
        "repositories"
        "documents"
        "downloads"
        "music"
        "pictures"
        "videos"
        { directory = ".local/share/gnupg"; mode = "0700"; }
        { directory = ".local/share/password-store"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".config/Signal"; mode = "0700"; }
      ];
      files = [ ];
    };
  };
}
