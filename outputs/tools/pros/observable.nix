{ lib, buildPythonPackage, python3Packages, fetchPypi }:

buildPythonPackage rec {
  pname = "observable";
  version = "1.0.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-l/6OnYwqYYXO42YfpfupzjjHujiIlBMpQM1qgWM2Jtk=";
  };

  doCheck = false;
}
