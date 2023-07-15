{
  services.gitolite = {
    enable = true;
    adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPv05cZiRXRO3EqVE/C/obDLekCmwPlAWNK5t+Fdpgwi";
    user = "git";
    group = "git";
  };

  state.directories = [
    { directory = "/var/lib/gitolite"; mode = "0700"; }
  ];
}
