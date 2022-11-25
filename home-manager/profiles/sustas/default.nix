{ pkgs, ... }:

{
  home.packages = with pkgs; [ sustas ];

  xdg.configFile."sustas/config.toml" = {
    text = ''
      format = "swaybar"

      [[modules]]
      kind = "wifi"

      [[modules]]
      kind = "bluetooth_device"
      address = "38:18:4C:4C:BC:29"

      [[modules]]
      kind = "bluetooth"
      address = "1C:99:57:7D:F1:D5"

      [[modules]]
      kind = "battery"

      [[modules]]
      kind = "clock"
    '';
    recursive = true;
  };
}
