{ pkgs, user, ... }:

let
  homeDir = builtins.getEnv "HOME";
in {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nrs" ''
      exec nixos-rebuild switch --flake /home/${user.name}/nix-config#
    '')
  ];
}
