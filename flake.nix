{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";
  };

  outputs = inputs:
    let
      supportedSystems = [ "x86_64-linux" ];

      eachSystem = inputs.nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = eachSystem (system: import inputs.nixpkgs { inherit system; });

      mkNixosConfigurations = inputs.nixpkgs.lib.mapAttrs
        (name: { system }: inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ({ nixpkgs.overlays = [ inputs.nur.overlay (import ./overlays) ]; })
            (./. + "/nixos/configurations/${name}")
          ];
        });
    in
    {
      formatter = eachSystem (system: nixpkgsFor."${system}".nixpkgs-fmt);

      devShells = eachSystem (system:
        let
          pkgs = nixpkgsFor."${system}";
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
              rnix-lsp
              stylua
            ];
          };
        });

      nixosConfigurations = mkNixosConfigurations {
        vm = { system = "x86_64-linux"; };
        x13 = { system = "x86_64-linux"; };
      };
    };
}
