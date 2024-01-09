{ pkgs, ... }:

{
  services.kanshi = {
    enable = true;

    profiles = {
      laptop.outputs = [{
        criteria = "eDP-1";
        status = "enable";
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

      ar.outputs = [
        {
          criteria = "Nreal Air 2 Pro 0x00008800";
          mode = "1920x1080@120Hz";
          scale = 2.0;
          position = "0,0";
        }
        {
          criteria = "eDP-1";
          position = "0,540";
        }
      ];
    };
  };

  wayland.windowManager.sway.config.startup = [{
    command = "${pkgs.systemd}/bin/systemctl --user reload-or-restart kanshi";
    always = true;
  }];
}
