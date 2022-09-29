{ config, lib, pkgs, ... }:

let
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

  clamshell-mode = pkgs.writeShellScriptBin "clamshell-mode" ''
    if grep -q open /proc/acpi/button/lid/LID/state; then
      ${pkgs.sway}/bin/swaymsg output eDP-1 enable
    else
      ${pkgs.sway}/bin/swaymsg output eDP-1 disable
    fi
  '';

  swaymsgThemeCommand = theme:
    let
      w = theme.windows;
      b = theme.bars;
    in
    lib.concatMapStringsSep ";" (lib.concatStringsSep " ") [
      [
        "client.focused"
        w.focused.border
        w.focused.background
        w.focused.text
        w.focused.indicator
        w.focused.childBorder
      ]

      [
        "client.focused_inactive"
        w.focusedInactive.border
        w.focusedInactive.background
        w.focusedInactive.text
        w.focusedInactive.indicator
        w.focusedInactive.childBorder
      ]

      [
        "client.focused_tab_title"
        w.focusedTabTitle.border
        w.focusedTabTitle.background
        w.focusedTabTitle.text
      ]

      [
        "client.unfocused"
        w.unfocused.border
        w.unfocused.background
        w.unfocused.text
        w.unfocused.indicator
        w.unfocused.childBorder
      ]

      [
        "client.urgent"
        w.urgent.border
        w.urgent.background
        w.urgent.text
        w.urgent.indicator
        w.urgent.childBorder
      ]

      [
        "bar main colors background"
        b.background
      ]

      [
        "bar main colors statusline"
        b.statusline
      ]

      [
        "bar main colors focused_background"
        b.focusedBackground
      ]

      [
        "bar main colors focused_statusline"
        b.focusedStatusline
      ]

      [
        "bar main colors focused_separator"
        b.focusedSeparator
      ]

      [
        "bar main colors focused_workspace"
        b.focusedWorkspace.border
        b.focusedWorkspace.background
        b.focusedWorkspace.text
      ]

      [
        "bar main colors active_workspace"
        b.activeWorkspace.border
        b.activeWorkspace.background
        b.activeWorkspace.text
      ]

      [
        "bar main colors inactive_workspace"
        b.inactiveWorkspace.border
        b.inactiveWorkspace.background
        b.inactiveWorkspace.text
      ]

      [
        "bar main colors urgent_workspace"
        b.urgentWorkspace.border
        b.urgentWorkspace.background
        b.urgentWorkspace.text
      ]

      [
        "bar main colors binding_mode"
        b.bindingMode.border
        b.bindingMode.background
        b.bindingMode.text
      ]
    ];

  darkTheme = {
    windows = {
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

    bars = {
      background = "#1d2021";
      statusline = "#ebdbb2";
      separator = "#928374";
      focusedBackground = "#1d2021";
      focusedStatusline = "#ebdbb2";
      focusedSeparator = "#928374";

      focusedWorkspace = {
        border = "#d65d0e";
        background = "#d65d0e";
        text = "#fbf1c7";
      };

      activeWorkspace = {
        border = "#d65d0e";
        background = "#1d2021";
        text = "#ebdbb2";
      };

      inactiveWorkspace = {
        border = "#1d2021";
        background = "#1d2021";
        text = "#ebdbb2";
      };

      urgentWorkspace = {
        border = "#cc241d";
        background = "#cc241d";
        text = "#fbf1c7";
      };

      bindingMode = {
        border = "#ebdbb2";
        background = "#ebdbb2";
        text = "#1d2021";
      };
    };
  };

  lightTheme = {
    windows = {
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

    bars = {
      background = "#f9f5d7";
      statusline = "#3c3836";
      separator = "#928374";
      focusedBackground = "#f9f5d7";
      focusedStatusline = "#3c3836";
      focusedSeparator = "#928374";

      focusedWorkspace = {
        border = "#d65d0e";
        background = "#d65d0e";
        text = "#282828";
      };

      activeWorkspace = {
        border = "#d65d0e";
        background = "#f9f5d7";
        text = "#3c3836";
      };

      inactiveWorkspace = {
        border = "#f9f5d7";
        background = "#f9f5d7";
        text = "#3c3836";
      };

      urgentWorkspace = {
        border = "#cc241d";
        background = "#f9f5d7";
        text = "#282828";
      };

      bindingMode = {
        border = "#3c3836";
        background = "#3c3836";
        text = "#f9f5d7";
      };
    };
  };
in
{
  wayland.windowManager.sway = {
    enable = true;

    xwayland = false;

    extraConfig = ''
      client.focused_tab_title ${darkTheme.windows.focusedTabTitle.border} ${darkTheme.windows.focusedTabTitle.background} ${darkTheme.windows.focusedTabTitle.text}

      titlebar_border_thickness 2

      for_window [title="Firefox — Sharing Indicator"] kill;

      bindswitch --reload --locked {
        lid:on output eDP-1 disable
        lid:off output eDP-1 enable
      }

      exec_always ${clamshell-mode}/bin/clamshell-mode
    '';

    config = {
      colors = {
        inherit (darkTheme.windows) focused focusedInactive unfocused urgent;
      };

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
        modifier = "Mod4";
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
        statusCommand = "${pkgs.i3status}/bin/i3status";
        colors = darkTheme.bars;
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
          "shift+1" = "rename workspace to 1";
          "shift+2" = "rename workspace to 2";
          "shift+3" = "rename workspace to 3";
          "shift+4" = "rename workspace to 4";
          "shift+5" = "rename workspace to 5";
          "shift+6" = "rename workspace to 6";
          "shift+7" = "rename workspace to 7";
          "shift+8" = "rename workspace to 8";
          "shift+9" = "rename workspace to 9";
          "h" = "move workspace to left";
          "j" = "move workspace to down";
          "k" = "move workspace to up";
          "l" = "move workspace to right";
        };
      };

      keybindings = {
        "Mod4+r" = "mode Resize";
        "Mod4+w" = "mode Workspace";

        "--locked XF86MonBrightnessDown" = "exec ${brightnessctl}/bin/brightnessctl set 5%-";
        "--locked XF86MonBrightnessUp" = "exec ${brightnessctl}/bin/brightnessctl set 5%+";
        "--locked XF86AudioRaiseVolume" = "exec ${pamixer}/bin/pamixer -i 5";
        "--locked XF86AudioLowerVolume" = "exec ${pamixer}/bin/pamixer -d 5";
        "--locked XF86AudioMute" = "exec ${pamixer}/bin/pamixer -t";
        "--locked XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";
        "--locked XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "--locked XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "Mod4+return" = "exec ${pkgs.alacritty}/bin/alacritty";
        # TODO: configure bemenu somewhere else
        "Mod4+o" = "exec ${pkgs.bemenu}/bin/bemenu-run -i -l 10";
        "Mod4+p" = "exec ${pkgs.pass-menu}/bin/pass-menu";

        "Mod4+tab" = "workspace back_and_forth";

        "Mod4+s" = "layout toggle split";
        "Mod4+shift+s" = "split toggle";
        "Mod4+t" = "layout toggle tabbed stacking";
        "Mod4+shift+t" = "layout toggle stacking tabbed";

        "Mod4+q" = "kill";

        "Mod4+f" = "fullscreen toggle";

        "Mod4+space" = "focus mode_toggle";
        "Mod4+shift+space" = "floating toggle";

        "Mod4+bracketleft" = "focus child";
        "Mod4+bracketright" = "focus parent";

        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        "Mod4+shift+h" = "move left";
        "Mod4+shift+j" = "move down";
        "Mod4+shift+k" = "move up";
        "Mod4+shift+l" = "move right";

        "Mod4+0" = "scratchpad show";
        "Mod4+shift+0" = "move container to scratchpad";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";

        "Mod4+shift+1" = "move container to workspace number 1";
        "Mod4+shift+2" = "move container to workspace number 2";
        "Mod4+shift+3" = "move container to workspace number 3";
        "Mod4+shift+4" = "move container to workspace number 4";
        "Mod4+shift+5" = "move container to workspace number 5";
        "Mod4+shift+6" = "move container to workspace number 6";
        "Mod4+shift+7" = "move container to workspace number 7";
        "Mod4+shift+8" = "move container to workspace number 8";
        "Mod4+shift+9" = "move container to workspace number 9";
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
