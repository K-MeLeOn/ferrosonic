{ lib
, rustPlatform
, pkg-config
, makeWrapper
, openssl
, mpv
, pipewire
, wireplumber
, cava
, src ? ./.
}:

rustPlatform.buildRustPackage rec {
  pname = "ferrosonic";
  version = "dev";

  inherit src;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  cargoHash = "sha256-vari4D3gHGYOOmVRQaEtmTkhT3E+fTnZgNZSQrnG0bc=";

  nativeBuildInputs = [ pkg-config makeWrapper ];
  buildInputs = [ openssl ];

  doCheck = false;

  postInstall = ''
    wrapProgram "$out/bin/ferrosonic" \
      --prefix PATH : ${lib.makeBinPath [ mpv pipewire wireplumber cava ]}
  '';
}
