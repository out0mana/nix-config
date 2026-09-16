{ pkgs, lib, ... }:

let
  pi = lib.getExe pkgs.pi-coding-agent;

  piSandboxed = pkgs.writeShellApplication {
    name = "pi";
    runtimeInputs = [ pkgs.bubblewrap ];
    text = ''
      sandbox=(
        --die-with-parent
        --unshare-all
        --share-net
        --ro-bind / /
        --dev /dev
        --proc /proc
        --tmpfs /tmp
        --tmpfs "$HOME"
        --bind "$PWD" "$PWD"
        --bind "$HOME/.pi" "$HOME/.pi"
        --chdir "$PWD"
        --setenv HOME "$HOME"
        --setenv PWD "$PWD"
        --setenv PATH "$PATH"
      )

      exec bwrap "''${sandbox[@]}" "${pi}" "$@"
    '';
  };
in
{
  environment.systemPackages = [
    piSandboxed
    pkgs.bubblewrap # sandbox 
  ];
}
