{ pkgs, ... }:

{
  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/after" = {
      source = ./after;
      recursive = true;
    };
  };

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
    extraPackages = with pkgs; [ fd ripgrep gitMinimal ];
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      vim-surround
      vim-repeat
      vim-dirvish
      vim-fugitive
      comment-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      fidget-nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      # Language support
      vim-nix
      dhall-vim
      vim-toml
      rust-vim
    ];
    extraConfig = "luafile ${./init.lua}";
  };
}
