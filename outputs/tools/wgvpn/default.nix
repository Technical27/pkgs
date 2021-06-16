{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  pname = "wgvpn";
  version = "0.0.0";

  dontUnpack = true;
  dontConfigure = true;

  src = ./wgvpn.fish;

  buildPhase = ''
    echo "#!${pkgs.fish}/bin/fish" > wgvpn
    cat ${src} >> wgvpn
  '';

  installPhase = ''
    install -Dm555 -t $out/bin wgvpn
  '';
}
