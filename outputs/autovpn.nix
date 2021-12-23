{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2021-12-22";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "d89ca06c25e0ac348b9e95e14be585a00056e070";
    sha256 = "sha256-iz2lW3TIb0WkUR61sqj77oC+rGTavPDL3q7nVBUAOWQ=";
  };

  cargoSha256 = "sha256-yhcsRiCRA5Qf27uvQl64UqcxABFKVHGRAl88Nnb8ioc=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libnl
    dbus
  ];
}
