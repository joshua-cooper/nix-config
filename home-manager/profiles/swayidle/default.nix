{ pkgs, ... }:

{
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 630;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];

    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };
}
