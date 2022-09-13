{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.rust-overlay.overlays.default ];
      };

      rust-toolchain = pkgs.rust-bin.stable."1.63.0".default;

      craneLib = (inputs.crane.mkLib pkgs).overrideToolchain rust-toolchain;

      commonArgs = {
        src = ./.;
      };

      cargoArtifacts = craneLib.buildDepsOnly (commonArgs);

      rust-template = craneLib.buildPackage (commonArgs // {
        inherit cargoArtifacts;
      });

      fmt = craneLib.cargoFmt (commonArgs);

      clippy = craneLib.cargoClippy (commonArgs // {
        inherit cargoArtifacts;
        cargoClippyExtraArgs = "--all-targets -- --deny warnings";
      });
    in
    {
      formatter = pkgs.nixpkgs-fmt;

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          nixpkgs-fmt
          rnix-lsp
          rust-toolchain
          rust-analyzer
        ];
      };

      checks = {
        inherit rust-template fmt clippy;
      };

      packages.default = rust-template;
    });
}

