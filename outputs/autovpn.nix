{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2022-03-29";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "fbfc4b8851ff087b3da1b3616ce1eedf2f283920";
    sha256 = "sha256-pUT/UPi2ujnNZE6UfeAiw+P4fRIsxWuRLwU+z0rU/j0=";
  };

  cargoSha256 = "sha256-fRs1fpupt748bbuZN6wdT5XIFD47L+6ygwzu3T0bse4=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libnl
    dbus
  ];
}
