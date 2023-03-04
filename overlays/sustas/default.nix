final: prev:

{
  sustas = prev.rustPlatform.buildRustPackage rec {
    pname = "sustas";
    version = "0.1.0";

    src = prev.fetchFromGitHub {
      owner = "joshua-cooper";
      repo = "sustas";
      rev = "afeebcbdfd804a32b230c192db8813dcd340ade6";
      sha256 = "sha256-1FOaZOlX1PwnYrL3asG9i2Lo1Z9nh0AKKkvIIef7Gps=";
    };

    cargoSha256 = "sha256-pZMno4gtPgFXsgnTvkf1j3mpi7Mykx/NhorceiP4P88=";

    meta = with prev.lib; {
      description = "A tool to generate desktop status lines";
      homepage = "https://github.com/joshua-cooper/sustas";
      license = with licenses; [ bsd0 ];
      maintainers = with maintainers; [ jc ];
    };
  };
}
