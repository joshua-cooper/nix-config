{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ bemenu ];
    sessionVariables.BEMENU_OPTS = lib.concatStringsSep " " [
      "--fn 'monospace 9'"
      "--ignorecase"
      "--no-overlap"
      "--list 15"
      "--prompt ''"
      "--prefix '➜'"
      "--center"
      "--fixed-height"
      "--width-factor 0.45"
      "--border 2"
      "--tb #1d2021"
      "--tf #ebdbb2"
      "--fb #1d2021"
      "--ff #ebdbb2"
      "--nb #1d2021"
      "--nf #ebdbb2"
      "--hb #1d2021"
      "--hf #d65d0e"
      "--sb #1d2021"
      "--sf #ebdbb2"
      "--scb #1d2021"
      "--scf #ebdbb2"
    ];
  };

  pinentry.bemenu.enable = true;
}
