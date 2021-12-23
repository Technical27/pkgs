{ pkgs, stdenv, lib, python3Packages, fetchFromGitHub }:

let
  scan-build = pkgs.python3Packages.callPackage ./scan-build.nix { };
  cobs = pkgs.python3Packages.callPackage ./cobs.nix { };
  observable = pkgs.python3Packages.callPackage ./observable.nix { };
  pypng = pkgs.python3Packages.callPackage ./pypng.nix { };
  # relies on an old version of click
  click = pkgs.python3Packages.callPackage ./click.nix { };
in

python3Packages.buildPythonPackage rec {
  name = "pros-cli";
  version = "3.2.3";

  patches = [ ./cli-ver.patch ];

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = name;
    rev = version;
    sha256 = "sha256-v4UCv6tNisYiPWQxQa9dCTQBv2vNx3giDBWqPpJ9op8=";
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
    observable
  ];

  meta = with lib; {
    homepage = "https://github.com/purduesigbots/pros-cli";
    description = "Command Line Interface for managing PROS projects";
    license = licenses.mpl20;
    maintainers = with maintainers; [ Technical27 ];
  };
}
