{ pkgs, ... }:

{
  services.kanshi = {
    enable = true;

    profiles = {
      laptop.outputs = [{
        criteria = "eDP-1";
      }];

      docked.outputs = [
        {
          criteria = "LG Electronics LG HDR 4K 0x000071E6";
          scale = 2.0;
          position = "0,0";
        }
        {
          criteria = "eDP-1";
          position = "320,1080";
        }
      ];
    };
  };

  wayland.windowManager.sway.config.startup = [{
    command = "${pkgs.systemd}/bin/systemctl --user reload-or-restart kanshi";
    always = true;
  }];
}
