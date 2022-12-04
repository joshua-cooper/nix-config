final: prev:

{
  wlroots = prev.wlroots_0_16;

  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: rec {
    version = "1.8-rc1";

    src = prev.fetchFromGitHub {
      owner = "swaywm";
      repo = "sway";
      rev = version;
      sha256 = "sha256-/qXlLl/mkI/WoVzGqAv50kvFaoZ5PUJ3NqucVGbOGXg=";
    };

    buildInputs = with final; old.buildInputs ++ [
      pcre2
    ];
  });

  sway = prev.sway.override {
    enableXWayland = false;
  };
}
