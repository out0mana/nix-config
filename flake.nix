{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      nixpkgs,
      ...
    }:
    let
      macUser = builtins.getEnv "USER";
    in
    {
      homeConfigurations."${macUser}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
          extraSpecialArgs = {
            inherit inputs;
            isNixOS = false;
            user.name = macUser;
          };
          modules = [ ./shared/home.nix ];
        };

      nixosConfigurations = {
        minibee = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            isNixOS = true;
            user = {
              name = "p001";
              uid = 1000;
            };
          };
          modules = [ ./minibee/configuration.nix ];
        };
      };
    };
}
