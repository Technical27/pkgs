{ lib, rustPlatform, fetchFromGitHub, pkg-config, libnl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "systemd-networkd-vpnc";
  version = "unstable-2022-08-17";

  src = fetchFromGitHub {
    owner = "kstep";
    repo = pname;
    rev = "e2df8f277a64cbbb38dc3dbaeffa3e50563c0bd5";
    sha256 = "sha256-9EMUTeKthBrJk1LED51xWwBNY08l9E4ghU51nIV8Mu4=";
  };

  cargoSha256 = "sha256-a9ukTffeKb4AYjv2i3BPfoyoQZs8P/27EY5BjzoKxzo=";
}
