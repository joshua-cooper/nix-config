{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

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
    let
      overlays = [
        inputs.nur.overlay
        (import ./overlays)
      ];

      mkNixosConfiguration = name: configuration: inputs.nixpkgs.lib.nixosSystem {
        inherit (configuration) system;
        specialArgs = { inherit inputs; };
        modules = [{ nixpkgs = { inherit overlays; }; }] ++ configuration.modules;
      };
    in
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs { inherit system overlays; };
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
      nixosConfigurations = inputs.nixpkgs.lib.mapAttrs mkNixosConfiguration {
        x13 = {
          system = "x86_64-linux";
          modules = [ ./nixos/configurations/x13 ];
        };
      };
    };
}
