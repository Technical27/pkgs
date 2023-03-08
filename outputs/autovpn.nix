{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2023-03-08";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "8912b63acfd7ea54c55dcc6c493c9e37d9d05e8b";
    sha256 = "sha256-M4WqCo8zA9rvD2PgPoimEtBHdO3Xpj2/WYMqf7HiF6k=";
  };

  cargoSha256 = "sha256-m5PQgDNLnbO1toAbWlVFQVGb88ZNXZVOF3Qam5wTOGg=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libnl
    dbus
  ];
}
