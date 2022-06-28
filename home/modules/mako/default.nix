{ pkgs, ... }:

{
  programs.mako = {
    enable = true;
    maxVisible = 5;
    anchor = "bottom-right";
    padding = "10";
    defaultTimeout = 10000;
    layer = "overlay";
    extraConfig = ''
      [mode=dark]
      background-color=#1d2021
      border-color=#3c3836
      text-color=#ebdbb2
      progress-color=over #282828
      [urgency=high]
      border-color=#cc241d

      [mode=light]
      background-color=#f9f5d7
      border-color=#ebdbb2
      text-color=#3c3836
      progress-color=over #d5c4a1
      [urgency=high]
      border-color=#cc241d

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
