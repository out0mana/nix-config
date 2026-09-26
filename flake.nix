{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  };
  outputs = inputs@{ nix-darwin, nixpkgs, ... }: {
    nixosConfigurations = {
      orangepi = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          user = {
            name = "p001";
            uid = 1001;
          };
        };
        modules = [ ./orangepi/configuration.nix ];
      };
      minibee = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          user = {
            name = "p001";
            uid = 1001;
          };
        };
        modules = [ ./minibee/configuration.nix ];
      };
    };
  };
}
