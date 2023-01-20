{
  hardware.bluetooth.enable = true;

  state.directories = [
    { directory = "/var/lib/bluetooth"; mode = "0700"; }
  ];
}
