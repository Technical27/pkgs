{ lib, rustPlatform, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2021-11-09";

  src = ./.;

  cargoSha256 = "sha256-tD3ag7eFabyplhkeojO4GDBvPeayImbLHbwyJlwcbpo=";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    libnl
    dbus
  ];
}
