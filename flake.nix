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

  outputs = inputs: with inputs;
    let
      overlays = [
        nur.overlay
        (import ./overlays)
      ];

      mkNixosConfiguration = name: configuration: nixpkgs.lib.nixosSystem {
        inherit (configuration) system;
        specialArgs = { inherit inputs; };
        modules = [{ nixpkgs = { inherit overlays; }; }] ++ configuration.modules;
      };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {
          formatter = pkgs.nixpkgs-fmt;

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
              rnix-lsp
              stylua
            ];
          };
        }) // {
      templates = import ./templates;

      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosConfiguration (import ./nixos/configurations);
    };
}
