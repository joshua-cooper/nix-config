{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.pinentry;
in
{
  options = {
    pinentry = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "pinentry";
      };

      default = mkOption {
        type = types.enum [ "curses" "bemenu" ];
        example = "bemenu";
        default = "curses";
        description = "The pinentry interface to use by default";
      };

      curses = {
        enable = mkEnableOption "pinentry-curses config generation for <option>home.pinentry</option>";
      };

      bemenu = {
        enable = mkEnableOption "pinentry-bemenu config generation for <option>home.pinentry</option>";
      };
    };
  };

  config =
    let
      pinentryBin = {
        curses = "${pkgs.pinentry-curses}/bin/pinentry-curses";
        bemenu = "${pkgs.pinentry-bemenu}/bin/pinentry-bemenu";
      };

      defaultPinentryBin = pinentryBin."${cfg.default}";

      branches = optionals cfg.curses.enable [
        "curses) exec ${pinentryBin.curses} \"$@\" ;;"
      ] ++ optionals cfg.bemenu.enable [
        "bemenu) exec ${pinentryBin.bemenu} \"$@\" ;;"
      ] ++ [
        "*) exec ${defaultPinentryBin} \"$@\" ;;"
      ];

      pinentry = pkgs.writeShellScriptBin "pinentry" ''
        set -e

        case "$PINENTRY_USER_DATA" in
          ${concatStringsSep "\n  " branches}
        esac
      '';
    in
    mkIf cfg.enable {
      services.gpg-agent = {
        pinentryFlavor = null;
        extraConfig = ''
          pinentry-program ${pinentry}/bin/pinentry
        '';
      };
    };
}
