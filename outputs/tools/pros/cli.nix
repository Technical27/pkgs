{ stdenv
, lib
, python3Packages
, fetchFromGitHub
, cobs
, scan-build
, rfc6266-parser
, observable
, pypng
, click
}:

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
    click
    pyserial
    cachetools
    requests
    tabulate
    jsonpickle
    semantic-version
    colorama
    pyzmq
    cobs
    scan-build
    rfc6266-parser
    sentry-sdk
    observable
    pypng
    typing-extensions
  ];
}
