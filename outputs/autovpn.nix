{ lib, rustPlatform, pkgs, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "autovpn";
  version = "unstable-2021-12-20";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "322aa46a75e8943b14124ed29dfe6a19e68e7205";
    sha256 = "sha256-Jflt/tuj8Sip6cKkFViP5V8tSpZNk0oUKA90/u/Plm0=";
  };

  cargoSha256 = "sha256-CGI4G7MjftgHMcL5SUexiN5TY2VDGmbAFmICDXOwKxU=";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    libnl
    dbus
  ];
}
