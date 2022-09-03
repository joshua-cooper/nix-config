{ pkgs, ... }:

let
  neovimMinimal = pkgs.neovim.override {
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
  };
in
{
  environment = {
    defaultPackages = with pkgs; [ neovimMinimal gitMinimal ];
    variables.EDITOR = "nvim";
  };
}
