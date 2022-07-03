{ pkgs, ... }:

let
  darkTheme = {
    border = "#3c3836";
    background = "#1d2021";
    text = "#ebdbb2";
    progress = "#282828";
  };

  lightTheme = {
    border = "#ebdbb2";
    background = "#f9f5d7";
    text = "#3c3836";
    progress = "#d5c4a1";
  };
in
{
  programs.mako = {
    enable = true;
    maxVisible = 5;
    anchor = "bottom-right";
    padding = "10";
    defaultTimeout = 10000;
    layer = "overlay";

    backgroundColor = darkTheme.background;
    borderColor = darkTheme.border;
    textColor = darkTheme.text;
    progressColor = darkTheme.progress;

    extraConfig = ''
      [mode=dark]
      border-color=${darkTheme.border}
      background-color=${darkTheme.background}
      text-color=${darkTheme.text}
      progress-color=over ${darkTheme.progress}

      [mode=light]
      border-color=${darkTheme.border}
      background-color=${darkTheme.background}
      text-color=${darkTheme.text}
      progress-color=over ${darkTheme.progress}

      [mode=do-not-disturb]
      invisible=1
    '';
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "Lightweight Wayland notification daemon";
      Documentation = "man:mako(1)";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
    };

    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      # ExecCondition = "${pkgs.runtimeShell} -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
      ExecStart = "${pkgs.mako}/bin/mako";
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  themes.scripts.mako = ''
    case "$THEME" in
      dark) exec ${pkgs.mako}/bin/makoctl set-mode dark ;;
      light) exec ${pkgs.mako}/bin/makoctl set-mode light ;;
    esac
  '';
}
