{
  inputs,
  isNixOS,
  pkgs,
  user,
  ...
}:

let
  homeModule = {
    imports = [
      ./nixvim.nix
      ./nrs.nix
      ./pi-sandboxed.nix
      ./tmux.nix
    ];

    home = {
      username = user.name;
      homeDirectory =
        if pkgs.stdenv.hostPlatform.isDarwin then
          "/Users/${user.name}"
        else
          "/home/${user.name}";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
in
if isNixOS then
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs user; };
      users.${user.name} = homeModule;
    };
  }
else
  homeModule
