{
  description = "AveryanAlex's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, agenix, home-manager, nur }@attrs:
    {
      nixosConfigurations = {
        alligator = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./machines/alligator.nix
          ];
        };
        whale = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./machines/whale.nix
          ];
        };
      };
    } // flake-utils.lib.eachSystem (with flake-utils.lib.system; [ x86_64-linux i686-linux aarch64-linux ])
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              agenix.defaultPackage.${system}
              pkgs.nebula
            ];
          };
        });
}
