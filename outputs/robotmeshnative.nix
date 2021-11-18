# src: https://www.robotmesh.com/downloads/robotmeshconnect-0.6_amd64.deb
{ stdenv, pkgs, fetchurl }:

stdenv.mkDerivation rec {
  pname = "robotmeshnative";
  version = "1.0.0";

  src = fetchurl {
    url = "https://www.robotmesh.com/downloads/robotmeshconnect-0.6_amd64.deb";
    sha256 = "sha256-7kPeLFRAfQnOJVwQZ4iYWE1NkM6zRhJ6k4WwRrOdkQg=";
  };

  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];

  buildInputs = with pkgs; [ libusb stdenv.cc.cc ];

  unpackPhase = ''
    mkdir pkg
    dpkg-deb -x $src pkg
    sourceRoot=pkg
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r etc $out/etc
    cp opt/RobotMeshConnect/RobotMeshConnectNativeHost $out/bin
    cp -r usr/lib $out/lib

    # fix native binary paths
    substituteInPlace $out/lib/mozilla/native-messaging-hosts/com.robotmesh.robotmeshconnect.json --replace /opt/RobotMeshConnect $out/bin
    substituteInPlace $out/etc/opt/chrome/native-messaging-hosts/com.robotmesh.robotmeshconnect.json --replace /opt/RobotMeshConnect $out/bin
  '';
}
