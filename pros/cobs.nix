{ lib, fetchPypi, buildPythonPackage }:

buildPythonPackage rec {
  pname = "cobs";
  version = "1.1.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-xPw24+HT/1dnCYKhsIVsoVJVq1bHPG+RXtakW1H6NBw=";
  };

  doCheck = false;
}
