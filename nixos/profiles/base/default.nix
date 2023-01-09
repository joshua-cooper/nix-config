{ pkgs, ... }:

{
  imports = [
    ../../modules/zfs-backup
  ];

  environment = {
    defaultPackages = with pkgs; [ neovim gitMinimal ];
    variables.EDITOR = "nvim";
  };

  security.sudo.enable = false;
}
