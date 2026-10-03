{
  lib,
  stdenv,
  fetchurl,
  makeBinaryWrapper,
  autoPatchelfHook,
  ripgrep,
  fd,
}:

let
  version = "0.99.1";
  releases = {
    x86_64-darwin = {
      arch = "darwin-x64";
      hash = "sha256-mtb8NW9NCLnRDopvkprBukkI3VM1RLqYnFTHO5K1PhM=";
    };
    aarch64-darwin = {
      arch = "darwin-arm64";
      hash = "sha256-RpKrodzUghm2HttOzrw8M/YZnr5lKZIo/OW6acMaI6Y=";
    };
    x86_64-linux = {
      arch = "linux-x64";
      hash = "sha256-yBuaNnuymF+kWiwNTxKxR6zENlVoORClq/k3/iIghCU=";
    };
    aarch64-linux = {
      arch = "linux-arm64";
      hash = "sha256-5jKp5VvIZSX/0PcdCRhdYwiD9kuc/IWPcx0e3JJxaVQ=";
    };
  };
  release = releases.${stdenv.hostPlatform.system};
in
stdenv.mkDerivation {
  pname = "pi-coding-agent";
  inherit version;

  src = fetchurl {
    url = "https://github.com/earendil-works/pi/releases/download/v${version}/pi-${release.arch}.tar.gz";
    inherit (release) hash;
  };
  sourceRoot = "pi";

  nativeBuildInputs = [ makeBinaryWrapper ] ++ lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ stdenv.cc.cc.lib ];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib/pi" "$out/bin"
    cp -R . "$out/lib/pi"
    makeWrapper "$out/lib/pi/pi" "$out/bin/pi" \
      --prefix PATH : ${lib.makeBinPath [ ripgrep fd ]}
    runHook postInstall
  '';

  meta = {
    description = "Pi coding agent CLI";
    homepage = "https://pi.dev/";
    license = lib.licenses.mit;
    mainProgram = "pi";
    platforms = builtins.attrNames releases;
  };
}
