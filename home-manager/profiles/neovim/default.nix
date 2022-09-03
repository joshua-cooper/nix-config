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
    extraPackages = with pkgs; [
      fd
      gitMinimal
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      comment-nvim
      dhall-vim
      editorconfig-vim
      fidget-nvim
      gruvbox-nvim
      nvim-lspconfig
      rust-vim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      tokyonight-nvim
      vim-fugitive
      vim-ledger
      vim-nix
      vim-repeat
      vim-surround
      vim-toml
    ];
    extraConfig = "luafile ${./init.lua}";
  };
}
