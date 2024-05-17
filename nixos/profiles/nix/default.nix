{ inputs, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;

    registry = lib.mapAttrs (name: flake: { inherit flake; }) inputs;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
