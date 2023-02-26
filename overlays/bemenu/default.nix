final: prev:

{
  bemenu = prev.bemenu.overrideAttrs (old: rec {
    pname = "bemenu";
    version = "0c0107e8cba23df06252bb58724f8a01e9fc3700";
    src = prev.fetchFromGitHub {
      owner = "Cloudef";
      repo = pname;
      rev = version;
      sha256 = "sha256-Mco0GxBbpy4oKzkZtisEFVCuScwr/ajkOyewjf6HLh4=";
    };
  });
}
