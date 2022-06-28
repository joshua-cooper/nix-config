{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.themes;
in
{
  options = {
    themes = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "themes";
      };

      scripts = mkOption {
        default = { };
        description = ''
          Scripts to run when changing themes.
        '';
      };
    };
  };

  config =
    let
      scripts = mapAttrsToList (name: script: "${pkgs.writeShellScriptBin "${name}-theme" script}/bin/${name}-theme") cfg.scripts;

      themeScript = pkgs.writeShellScriptBin "theme" ''
        export THEME="$1"
        ${concatStringsSep " &\n" scripts} &
        wait
      '';
    in
    mkIf cfg.enable {
      home.packages = [ themeScript ];

      wayland.windowManager.sway.config.startup = [{
        command = "${themeScript}/bin/theme dark";
        always = true;
      }];
    };
}
