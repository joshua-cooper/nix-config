{ pkgs, ... }:

let
  opt = plugin: {
    inherit plugin;
    type = "lua";
    optional = true;
  };
in
{
  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/plugin" = {
      source = ./plugin;
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
      # Base
      (opt comment-nvim)
      (opt dirbuf-nvim)
      (opt neogit)
      (opt nvim-autopairs)
      (opt nvim-surround)
      (opt telescope-fzf-native-nvim)
      (opt telescope-nvim)
      (opt telescope-ui-select-nvim)
      (opt vim-fugitive)
      null-ls-nvim
      nvim-treesitter.withAllGrammars

      # Themes
      gruvbox-nvim
      tokyonight-nvim

      # Language support
      vim-nix
    ];
  };
}
