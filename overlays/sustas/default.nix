final: prev:

{
  sustas = prev.rustPlatform.buildRustPackage rec {
    pname = "sustas";
    version = "0.1.0";

    src = prev.fetchFromGitHub {
      owner = "joshua-cooper";
      repo = "sustas";
      rev = "933c112d4cc59b6e3b2733a6b36785532026790d";
      sha256 = "sha256-LIA34PiXFGtC/Ku8anklil6U9AVfaQW25/038OUp3PI=";
    };

    cargoSha256 = "sha256-/nkBJTf55+DtVzBH4KGmPWdXficr/E4UQrs5KFsyE08=";

    meta = with prev.lib; {
      description = "A tool to generate desktop status lines";
      homepage = "https://github.com/joshua-cooper/sustas";
      license = with licenses; [ bsd0 ];
      maintainers = with maintainers; [ jc ];
    };
  };
}
