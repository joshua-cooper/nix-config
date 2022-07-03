{ config, lib, pkgs, ... }:

let
  modifier = "Mod4";

  brightnessctl = pkgs.writeShellScriptBin "brightnessctl" ''
    ${pkgs.brightnessctl}/bin/brightnessctl "$@"
    BRIGHTNESS=$(${pkgs.brightnessctl}/bin/brightnessctl info | grep "Current brightness:" | sed "s/.*(\(.*\))/\1/")
    ${pkgs.libnotify}/bin/notify-send \
      -h string:x-canonical-private-synchronous:brightness \
      -h int:value:"$BRIGHTNESS" \
      Brightness \
      "$BRIGHTNESS"
  '';

  pamixer = pkgs.writeShellScriptBin "pamixer" ''
    ${pkgs.pamixer}/bin/pamixer "$@"
    VOLUME=$(${pkgs.pamixer}/bin/pamixer --get-volume)
    MUTED=$(${pkgs.pamixer}/bin/pamixer --get-mute > /dev/null && echo " (muted)")
    ${pkgs.libnotify}/bin/notify-send \
      -h string:x-canonical-private-synchronous:volume \
      -h int:value:"$VOLUME" \
      Volume \
      "$VOLUME%$MUTED"
  '';

  swaymsgThemeCommand = theme:
    let
      inherit (theme) focused focusedInactive focusedTabTitle unfocused urgent;
    in
    lib.concatMapStringsSep ";" (lib.concatStringsSep " ") [
      [
        "client.focused"
        focused.border
        focused.background
        focused.text
        focused.indicator
        focused.childBorder
      ]

      [
        "client.focused_inactive"
        focusedInactive.border
        focusedInactive.background
        focusedInactive.text
        focusedInactive.indicator
        focusedInactive.childBorder
      ]

      [
        "client.focused_tab_title"
        focusedTabTitle.border
        focusedTabTitle.background
        focusedTabTitle.text
      ]

      [
        "client.unfocused"
        unfocused.border
        unfocused.background
        unfocused.text
        unfocused.indicator
        unfocused.childBorder
      ]

      [
        "client.urgent"
        urgent.border
        urgent.background
        urgent.text
        urgent.indicator
        urgent.childBorder
      ]
    ];

  darkTheme = {
    focused = {
      border = "#d65d0e";
      background = "#282828";
      text = "#fbf1c7";
      indicator = "#d65d0e";
      childBorder = "#d65d0e";
    };

    focusedInactive = {
      border = "#1d2021";
      background = "#282828";
      text = "#fbf1c7";
      indicator = "#1d2021";
      childBorder = "#1d2021";
    };

    focusedTabTitle = {
      border = "#d65d0e";
      background = "#282828";
      text = "#fbf1c7";
    };

    unfocused = {
      border = "#1d2021";
      background = "#282828";
      text = "#fbf1c7";
      indicator = "#1d2021";
      childBorder = "#1d2021";
    };

    urgent = {
      border = "#cc241d";
      background = "#282828";
      text = "#fbf1c7";
      indicator = "#cc241d";
      childBorder = "#cc241d";
    };
  };

  lightTheme = {
    focused = {
      border = "#d65d0e";
      background = "#fbf1c7";
      text = "#282828";
      indicator = "#d65d0e";
      childBorder = "#d65d0e";
    };

    focusedInactive = {
      border = "#f9f5d7";
      background = "#fbf1c7";
      text = "#282828";
      indicator = "#f9f5d7";
      childBorder = "#f9f5d7";
    };

    focusedTabTitle = {
      border = "#d65d0e";
      background = "#fbf1c7";
      text = "#282828";
    };

    unfocused = {
      border = "#f9f5d7";
      background = "#fbf1c7";
      text = "#282828";
      indicator = "#f9f5d7";
      childBorder = "#f9f5d7";
    };

    urgent = {
      border = "#cc241d";
      background = "#fbf1c7";
      text = "#282828";
      indicator = "#cc241d";
      childBorder = "#cc241d";
    };
  };
in
{
  wayland.windowManager.sway = {
    enable = true;

    xwayland = false;

    extraConfig = ''
      titlebar_border_thickness 2

      for_window [title="Firefox — Sharing Indicator"] kill;
    '';

    config = {
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
        inner = 6;
        smartBorders = "on";
      };

      bars = [{
        id = "main";
        position = "top";
      }];

      modes = {
        Resize = {
          "escape" = "mode default";
          "return" = "mode default";
          "h" = "resize shrink width 10px";
          "j" = "resize shrink height 10px";
          "k" = "resize grow height 10px";
          "l" = "resize grow width 10px";
        };

        Workspace = {
          "escape" = "mode default";
          "return" = "mode default";
          "1" = "workspace number 1";
          "2" = "workspace number 2";
          "3" = "workspace number 3";
          "4" = "workspace number 4";
          "5" = "workspace number 5";
          "6" = "workspace number 6";
          "7" = "workspace number 7";
          "8" = "workspace number 8";
          "9" = "workspace number 9";
          "h" = "move workspace to left";
          "j" = "move workspace to down";
          "k" = "move workspace to up";
          "l" = "move workspace to right";
        };
      };

      keybindings = {
        "${modifier}+r" = "mode Resize";
        "${modifier}+w" = "mode Workspace";

        "--locked XF86MonBrightnessDown" = "exec ${brightnessctl}/bin/brightnessctl set 5%-";
        "--locked XF86MonBrightnessUp" = "exec ${brightnessctl}/bin/brightnessctl set 5%+";
        "--locked XF86AudioRaiseVolume" = "exec ${pamixer}/bin/pamixer -i 5";
        "--locked XF86AudioLowerVolume" = "exec ${pamixer}/bin/pamixer -d 5";
        "--locked XF86AudioMute" = "exec ${pamixer}/bin/pamixer -t";
        "--locked XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "--locked XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${modifier}+return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+o" = "exec ${pkgs.bemenu}/bin/bemenu-run";

        "${modifier}+tab" = "workspace back_and_forth";

        "${modifier}+s" = "layout toggle split";
        "${modifier}+shift+s" = "split toggle";
        "${modifier}+t" = "layout toggle tabbed stacking";
        "${modifier}+shift+t" = "layout toggle stacking tabbed";

        "${modifier}+q" = "kill";

        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+space" = "focus mode_toggle";
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

        "${modifier}+0" = "scratchpad show";
        "${modifier}+shift+0" = "move container to scratchpad";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+shift+1" = "move container to workspace number 1";
        "${modifier}+shift+2" = "move container to workspace number 2";
        "${modifier}+shift+3" = "move container to workspace number 3";
        "${modifier}+shift+4" = "move container to workspace number 4";
        "${modifier}+shift+5" = "move container to workspace number 5";
        "${modifier}+shift+6" = "move container to workspace number 6";
        "${modifier}+shift+7" = "move container to workspace number 7";
        "${modifier}+shift+8" = "move container to workspace number 8";
        "${modifier}+shift+9" = "move container to workspace number 9";
      };
    };
  };

  themes.scripts.sway = ''
    case "$THEME" in
      dark) exec ${pkgs.sway}/bin/swaymsg "${swaymsgThemeCommand darkTheme}" ;;
      light) exec ${pkgs.sway}/bin/swaymsg "${swaymsgThemeCommand lightTheme}" ;;
    esac
  '';
}
