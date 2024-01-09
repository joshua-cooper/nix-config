final: prev:

{
  fd = prev.fd.overrideAttrs (old: rec {
    version = "8.7.1";

    src = final.fetchFromGitHub {
      owner = "sharkdp";
      repo = "fd";
      rev = "v${version}";
      hash = "sha256-euQiMVPKE1/YG04VKMFUA27OtoGENNhqeE0iiF/X7uc=";
    };

    cargoDeps = old.cargoDeps.overrideAttrs {
      inherit src;
      name = "${old.pname}-${version}-vendor.tar.gz";
      outputHash = "sha256-doeZTjFPXmxIPYX3IBtetePoNkIHnl6oPJFtXD1tgZY=";
    };
  });
}
