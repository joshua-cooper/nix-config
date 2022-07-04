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
        set_theme() {
          export THEME="$1"
          echo "$THEME" > ~/.local/share/theme
          ${concatStringsSep " &\n  " scripts} &
        }

        get_theme() {
          head -n1 ~/.local/share/theme
        }

        toggle_theme() {
          case "$(get_theme)" in
            dark) set_theme light ;;
            light) set_theme dark ;;
          esac
        }

        case "$1" in
          set) shift; set_theme "$@" ;;
          get) shift; get_theme "$@" ;;
          toggle) shift; toggle_theme "$@" ;;
        esac

        wait
      '';
    in
    mkIf cfg.enable {
      home.packages = [ themeScript ];

      wayland.windowManager.sway.config.startup = [{
        command = "${themeScript}/bin/theme set dark";
        always = true;
      }];
    };
}
