{ pkgs, ... }:

let
  neovimMinimal = pkgs.neovim.override {
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
  };
in
{
  imports = [
    ../../modules/zfs-backup
  ];

  environment = {
    defaultPackages = with pkgs; [ neovimMinimal gitMinimal ];
    variables.EDITOR = "nvim";
  };

  security.sudo.enable = false;
}
