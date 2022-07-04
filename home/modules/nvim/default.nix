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
      # Themes
      tokyonight-nvim
      gruvbox-nvim
      # Features
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
      vim-ledger
    ];
    extraConfig = "luafile ${./init.lua}";
  };

  themes.scripts.nvim = ''
    pkill -u "$(id -u)" --signal USR1 -x nvim
  '';
}
