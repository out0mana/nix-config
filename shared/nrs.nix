{ pkgs, user, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "nrs" ''
      ${
        if pkgs.stdenv.hostPlatform.isDarwin then
          ''exec home-manager switch --flake /Users/${user.name}/repos/nix-config --impure''
        else
          ''exec nixos-rebuild switch --flake /home/${user.name}/nix-config#''
      }
    '')
  ];
}
