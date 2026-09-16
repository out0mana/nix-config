{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ nix-darwin, nixpkgs, ... }: {
    nixosConfigurations.orangepi = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        user = {
          name = "p001";
          uid = 1001;
        };
      };
      modules = [ ./orangepi/configuration.nix ];
    };
    darwinConfigurations.C02D120BMD6R = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./work/configuration.nix ];
    };
  };
}
