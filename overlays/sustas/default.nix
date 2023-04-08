final: prev:

{
  sustas = prev.rustPlatform.buildRustPackage rec {
    pname = "sustas";
    version = "0.1.0";

    src = prev.fetchFromGitHub {
      owner = "joshua-cooper";
      repo = "sustas";
      rev = "d353678a9152b429cc917e6f9d3a67b0e0b97aee";
      sha256 = "sha256-yoZe8t6s0foL84DRqW6PO1dCnCTEejhXT9FQ2XunICE=";
    };

    cargoSha256 = "sha256-qo6mOWTb/JA55ZDvAadsuC17tJH7naXFytgoPgfjv7E=";

    meta = with prev.lib; {
      description = "A tool to generate desktop status lines";
      homepage = "https://github.com/joshua-cooper/sustas";
      license = with licenses; [ bsd0 ];
      maintainers = with maintainers; [ jc ];
    };
  };
}
