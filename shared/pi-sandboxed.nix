{
  lib,
  pkgs,
  ...
}:

let
  pi = lib.getExe (pkgs.callPackage ./pi-latest.nix { });

  piSandboxed =
    if pkgs.stdenv.hostPlatform.isDarwin then
      pkgs.writeShellApplication {
        name = "pi";
        text = ''
          mkdir -p "$HOME/.pi"
          export TMPDIR=/tmp/

          exec /usr/bin/sandbox-exec \
            -D "WORK_DIR=$PWD" \
            -D "PI_DIR=$HOME/.pi" \
            -p '
              (version 1)
              (allow default)
              (deny file-write*)
              (allow file-write*
                (subpath (param "WORK_DIR"))
                (subpath (param "PI_DIR"))
                (subpath "/private/tmp"))
              (allow file-write* (literal "/dev/null"))
            ' \
            "${pi}" "$@"
        '';
      }
    else
      pkgs.writeShellApplication {
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

  packages = [ piSandboxed ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.bubblewrap;
in
{
  home.packages = packages;
}
