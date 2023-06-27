{
  services.tailscale.enable = true;

  state.directories = [
    { directory = "/var/lib/tailscale"; mode = "0700"; }
  ];
}
