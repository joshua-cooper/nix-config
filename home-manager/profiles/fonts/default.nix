{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
  };

  home.packages = with pkgs; [
    recursive
    cascadia-code
    noto-fonts-cjk
    font-awesome
  ];
}
