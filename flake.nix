{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur.url = "github:nix-community/nur";

    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };
  };

  outputs = inputs:
    with inputs;
    with nixpkgs.lib;
    let
      supportedSystems = [
        "x86_64-linux"
      ];

      overlays = [
        nur.overlay
      ] ++ attrValues (import ./overlays);

      mkNixosConfiguration = name: configuration: nixpkgs.lib.nixosSystem {
        inherit (configuration) system;
        specialArgs = { inherit inputs; };
        modules = [{ nixpkgs = { inherit overlays; }; }] ++ configuration.modules;
      };
    in
    {
      overlays = import ./overlays;

      templates = import ./templates;

      nixosConfigurations = mapAttrs mkNixosConfiguration (import ./nixos/configurations);
    } // flake-utils.lib.eachSystem supportedSystems
      (system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {
          formatter = pkgs.nixpkgs-fmt;

          checks = { };

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
              rnix-lsp
              stylua
            ];
          };
        });
}
