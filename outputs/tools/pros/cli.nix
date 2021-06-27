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
  version = "3.2.1";

  patches = [ ./cli-ver.patch ];

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = name;
    rev = version;
    sha256 = "sha256-xlDoXgKAniVkla3qcVJWE5u73c/k69rGbgZB3U/Bp5c=";
  };

  doCheck = false;

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
