{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../shared/nixvim.nix
      ../shared/tmux.nix
      ../shared/pi-sandboxed.nix
    ];
}
