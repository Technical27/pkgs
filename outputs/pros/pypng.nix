{ lib, buildPythonPackage, python3Packages, fetchPypi }:

buildPythonPackage rec {
  pname = "pypng";
  version = "0.0.20";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-EDKDNEDJG6/uOKQsOMAtAEMbJMQpJ/6z5jsQTYVQFws=";
  };

  doCheck = false;
  pythonImportsCheck = [ "png" ];
}
