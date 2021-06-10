{ lib, buildPythonPackage, python3Packages, fetchPypi, lepl }:

buildPythonPackage rec {
  pname = "rfc6266-parser";
  version = "0.0.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-brfXIjx1cnrGl9MVDD7qRh4WYKnKEWuym1fXUavu7GU=";
  };

  propagatedBuildInputs = [ lepl ];

  doCheck = false;
}
