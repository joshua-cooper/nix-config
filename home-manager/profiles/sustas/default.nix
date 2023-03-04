{ pkgs, ... }:

{
  home.packages = with pkgs; [ sustas ];

  xdg.configFile."sustas/config.toml" = {
    text = ''
      format = "swaybar"

      [[modules]]
      kind = "wifi"
      interface = "wlan0"

      [[modules]]
      kind = "battery"
      name = "BAT0"

      [[modules]]
      kind = "clock"
    '';
    recursive = true;
  };
}
