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
      (opt nvim-surround)
      (opt telescope-fzf-native-nvim)
      (opt telescope-nvim)
      (opt telescope-ui-select-nvim)
      (opt vim-fugitive)
      null-ls-nvim

      # Themes
      gruvbox-nvim
      tokyonight-nvim

      # Language support
      vim-nix
      dhall-vim

      (nvim-treesitter.withPlugins (plugins: with plugins; [
        astro
        bash
        css
        dockerfile
        fish
        git_rebase
        gitattributes
        gitcommit
        gitignore
        help
        html
        ini
        javascript
        jsdoc
        json
        ledger
        lua
        markdown
        markdown_inline
        nix
        prisma
        regex
        rust
        sql
        svelte
        toml
        tsx
        typescript
        vim
        yaml
      ]))
    ];
  };
}
