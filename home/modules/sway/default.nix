{ config, lib, pkgs, ... }:

let
  modifier = "Mod4";
in
{
  wayland.windowManager.sway = {
    enable = true;

    xwayland = false;

    extraConfig = ''
      bindswitch --locked {
        lid:on output eDP-1 disable
        lid:off output eDP-1 enable
      }
    '';

    config = {
      startup = lib.optionals config.services.kanshi.enable [{
        command = "${pkgs.systemd}/bin/systemctl --user reload-or-restart kanshi";
        always = true;
      }];

      seat."*".hide_cursor = "5000";

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "50";
          xkb_options = "caps:escape";
        };

        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };

      window = {
        titlebar = false;
        border = 2;
      };

      floating = {
        inherit modifier;
        titlebar = true;
        border = 2;
      };

      gaps = {
        inner = 4;
        smartBorders = "on";
      };

      bars = [{
        id = "main";
        position = "bottom";
        mode = "hide";
      }];

      modes = {
        Resize = {
          "escape" = "mode default";
          "return" = "mode default";
          "h" = "resize shrink width 10px";
          "j" = "resize grow height 10px";
          "k" = "resize shrink height 10px";
          "l" = "resize grow width 10px";
        };
      };

      keybindings = {
        "${modifier}+r" = "mode Resize";

        "--locked XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "--locked XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${modifier}+return" = "exec ${pkgs.alacritty}/bin/alacritty";

        "${modifier}+tab" = "workspace back_and_forth";

        "${modifier}+s" = "layout toggle split";
        "${modifier}+shift+s" = "split toggle";
        "${modifier}+t" = "layout toggle tabbed stacking";
        "${modifier}+shift+t" = "layout toggle stacking tabbed";

        "${modifier}+q" = "kill";

        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+space" = "focus mode toggle";
        "${modifier}+shift+space" = "floating toggle";

        "${modifier}+bracketleft" = "focus child";
        "${modifier}+bracketright" = "focus parent";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+shift+h" = "move left";
        "${modifier}+shift+j" = "move down";
        "${modifier}+shift+k" = "move up";
        "${modifier}+shift+l" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "scratchpad show";

        "${modifier}+shift+1" = "move container to workspace number 1";
        "${modifier}+shift+2" = "move container to workspace number 2";
        "${modifier}+shift+3" = "move container to workspace number 3";
        "${modifier}+shift+4" = "move container to workspace number 4";
        "${modifier}+shift+5" = "move container to workspace number 5";
        "${modifier}+shift+6" = "move container to workspace number 6";
        "${modifier}+shift+7" = "move container to workspace number 7";
        "${modifier}+shift+8" = "move container to workspace number 8";
        "${modifier}+shift+9" = "move container to workspace number 9";
        "${modifier}+shift+0" = "move container to scratchpad";
      };
    };
  };
}
