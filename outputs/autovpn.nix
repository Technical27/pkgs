{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2023-03-08";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "c281a5614d10555017458a40d30cd7697d184b1b";
    sha256 = "sha256-QeIjBLpnPLtUjTFkkRvylxIZ/uhBDYe2o3BQPjkr+zU=";
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
