{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/nur";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      lib = inputs.nixpkgs.lib;

      supportedSystems = [
        "x86_64-linux"
      ];

      overlays = [ inputs.nur.overlay ] ++ lib.attrValues (import ./overlays);

      pkgsFor = system: import inputs.nixpkgs { inherit system overlays; };

      eachSystem = f: lib.genAttrs supportedSystems (system: f (pkgsFor system));

      mkNixosConfiguration = name: configuration: lib.nixosSystem {
        system = configuration.system;
        specialArgs.inputs = inputs;
        modules = [{ nixpkgs.overlays = overlays; }] ++ configuration.modules;
      };

      mkHomeConfiguration = name: configuration: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor configuration.system;
        modules = configuration.modules;
      };
    in
    {
      formatter = eachSystem (pkgs: pkgs.nixpkgs-fmt);

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nixpkgs-fmt
            stylua
          ];
        };
      });

      overlays = import ./overlays;

      templates = import ./templates;

      nixosConfigurations = lib.mapAttrs mkNixosConfiguration (import ./nixos/configurations);

      homeConfigurations = lib.mapAttrs mkHomeConfiguration (import ./home-manager/configurations);
    };
}
