final: prev:

{
  neovim = prev.neovim.override {
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
  };

  vimPlugins = prev.vimPlugins // {
    dirbuf-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
      name = "dirbuf.nvim";
      src = prev.fetchFromGitHub {
        owner = "elihunter173";
        repo = "dirbuf.nvim";
        rev = "ac7ad3c8e61630d15af1f6266441984f54f54fd2";
        hash = "sha256-35pNyVO0Yx+g5nvcFOmi2npb9Bnv83mkOtQJ2eKbSyc=";
      };
    };
  };
}
