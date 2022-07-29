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
          criteria = "eDP-1";
          position = "0,160";
        }
        {
          criteria = "Goldstar Company Ltd LG HDR 4K 0x000071E6";
          scale = 2.0;
          position = "1280,0";
        }
      ];
    };
  };

  wayland.windowManager.sway.config.startup = [{
    command = "${pkgs.systemd}/bin/systemctl --user reload-or-restart kanshi";
    always = true;
  }];
}
