{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2022-10-23";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "2161639021565fe4c31a54405dff4d7444274acf";
    sha256 = "sha256-/LiTjqhnS+jV3QeMoEI/CrnD0ivlO3ECWqkwef9p2N8=";
  };

  cargoSha256 = "sha256-f/5KbDkgOLEtTfWRqRrwEcBv0f9m74kdoNdwVuFvqu8=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libnl
    dbus
  ];
}
