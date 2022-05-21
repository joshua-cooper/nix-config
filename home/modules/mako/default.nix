{ pkgs, ... }:

{
  programs.mako = {
    enable = true;
    maxVisible = 5;
    anchor = "bottom-right";
    padding = "10";
    defaultTimeout = 10000;
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
      ExecCondition = "${pkgs.runtimeShell} -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
      ExecStart = "${pkgs.mako}/bin/mako";
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
