final: prev:

{
  neovim = prev.neovim.override {
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
  };
}
