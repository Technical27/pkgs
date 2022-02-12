{ stdenv, lib, python3Packages, fetchFromGitHub }:

let
  dasbus = python3Packages.callPackage ./dasbus.nix { };
in
python3Packages.buildPythonPackage rec {
  pname = "ancs4linux";
  version = "unstable-2022-01-21";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "pzmarzly";
    repo = pname;
    rev = "129c7c1824a76ddceb2010207fc309d47f2e3133";
    sha256 = "sha256-gEQS7s/XQSXQYzB04MFJVXeucWsIrCPGRr5YiI5AlQQ=";
  };

  nativeBuildinputs = with python3Packages; [
    poetry
    mypy
    black
    isort
  ];

  propagatedBuildInputs = with python3Packages; [
    poetry
    pygobject3
    dasbus
    typer
  ];

  postInstall = ''
    cd ${src}/autorun
    mkdir -p $out/lib/systemd/{system,user}
    mkdir -p $out/share/dbus-1/system.d


    install -m 644 ancs4linux-observer.service $out/lib/systemd/system/ancs4linux-observer.service
    install -m 644 ancs4linux-observer.xml $out/share/dbus-1/system.d/ancs4linux-observer.conf
    install -m 644 ancs4linux-advertising.service $out/lib/systemd/system/ancs4linux-advertising.service
    install -m 644 ancs4linux-advertising.xml $out/share/dbus-1/system.d/ancs4linux-advertising.conf
    install -m 644 ancs4linux-desktop-integration.service $out/lib/systemd/user/ancs4linux-desktop-integration.service

    substituteInPlace $out/lib/systemd/system/ancs4linux-observer.service --replace "/usr/local" $out
    substituteInPlace $out/lib/systemd/system/ancs4linux-advertising.service --replace "/usr/local" $out
    substituteInPlace $out/lib/systemd/user/ancs4linux-desktop-integration.service --replace "/usr/local" $out
  '';
}
