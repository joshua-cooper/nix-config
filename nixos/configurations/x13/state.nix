{
  environment.persistence."/state" = {
    directories = [
      "/var/log"
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
        { directory = ".config/VSCodium"; mode = "0700"; }
      ];
      files = [ ];
    };
  };
}
