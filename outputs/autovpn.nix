{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2022-03-31";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "f4aa18d95d282d472ea935aea63951eac28f008b";
    sha256 = "sha256-iRXuIMU7Saw4R18wH32is22yltpVEKzqYjiMiP6EAAk=";
  };

  cargoSha256 = "sha256-RR6Z4oCP3bX7gvyzu59UJwbfKu3IsaWTMWECxyZCwFg=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libnl
    dbus
  ];
}
