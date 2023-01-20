{ config, lib, ... }:

with lib;

let
  cfg = config.state;
in

{
  options.state = {
    enable = mkEnableOption "Track opt-in state";
    # TODO: give these proper types
    directories = mkOption { };
    files = mkOption { };
  };

  config = mkIf cfg.enable {
    environment.persistence."/state" = {
      inherit (cfg) directories files;
    };
  };
}

