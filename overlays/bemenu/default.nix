final: prev:

{
  bemenu = prev.bemenu.overrideAttrs (old: rec {
    pname = "bemenu";
    version = "master";
    src = prev.fetchFromGitHub {
      owner = "Cloudef";
      repo = pname;
      rev = version;
      sha256 = "sha256-JtMvsHXdY3Khu/TRPM0cHfrWqjbrJAPzgYk4hX6WMsQ=";
    };
  });
}
