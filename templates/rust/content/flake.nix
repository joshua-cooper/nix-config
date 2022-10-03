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

  outputs = inputs: with inputs; flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };

      rust-toolchain = pkgs.rust-bin.stable.latest.default;

      craneLib = (crane.mkLib pkgs).overrideToolchain rust-toolchain;

      commonArgs = {
        src = ./.;
      };

      cargoArtifacts = craneLib.buildDepsOnly commonArgs;

      rust-template = craneLib.buildPackage (commonArgs // {
        inherit cargoArtifacts;
      });

      cargo-fmt = craneLib.cargoFmt commonArgs;

      cargo-clippy = craneLib.cargoClippy (commonArgs // {
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
        inherit rust-template cargo-fmt cargo-clippy;
      };

      packages.default = rust-template;
    });
}

