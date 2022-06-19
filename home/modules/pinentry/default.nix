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
      # TODO: make this configurable
      defaultPinentry = "${pkgs.pinentry-curses}/bin/pinentry-curses";

      branches = optionals cfg.curses.enable [
        "curses) exec ${pkgs.pinentry-curses}/bin/pinentry-curses \"$@\" ;;"
      ] ++ optionals cfg.bemenu.enable [
        "bemenu) exec ${pkgs.pinentry-bemenu}/bin/pinentry-bemenu \"$@\" ;;"
      ] ++ [
        "*) exec ${defaultPinentry} \"$@\" ;;"
      ];

      pinentry = pkgs.writeShellScriptBin "pinentry" ''
        set -eu

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
