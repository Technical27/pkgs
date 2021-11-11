{ pkgs, stdenv, lib, python3Packages, fetchFromGitHub }:

let
  scan-build = pkgs.python3Packages.callPackage ./scan-build.nix { };
  cobs = pkgs.python3Packages.callPackage ./cobs.nix { };
  rfc6266-parser = pkgs.python3Packages.callPackage ./rfc6266.nix { inherit lepl; };
  observable = pkgs.python3Packages.callPackage ./observable.nix { };
  pypng = pkgs.python3Packages.callPackage ./pypng.nix { };
  lepl = pkgs.python3Packages.callPackage ./lepl.nix { };
  # relies on an old version of click
  click = pkgs.python3Packages.callPackage ./click.nix { };
in

python3Packages.buildPythonPackage rec {
  name = "pros-cli";
  version = "3.2.2";

  patches = [ ./cli-ver.patch ];

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = name;
    rev = version;
    sha256 = "sha256-bSByUlNadILnn2985TohVI28Co8gUaX86pT3foRd8is=";
  };

  doCheck = false;
  pythonImportsCheck = [ "pros" ];

  propagatedBuildInputs = with python3Packages; [
    pyserial
    cachetools
    requests
    tabulate
    jsonpickle
    semantic-version
    colorama
    pyzmq
    sentry-sdk
    typing-extensions
  ] ++ [
    # custom deps that aren't in repos or are old
    click
    cobs
    pypng
    scan-build
    rfc6266-parser
    observable
  ];

  meta = {
    homepage = "https://github.com/purduesigbots/pros-cli";
    description = "Command Line Interface for managing PROS projects";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ Technical27 ];
  };
}
