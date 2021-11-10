{ lib, buildPythonPackage, python3Packages, fetchPypi }:

buildPythonPackage rec {
  pname = "LEPL";
  version = "5.1.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-qHFccJMINQzkr+1dUlaCZWiG04FBOH7IfURCHajUE5c=";
  };

  doCheck = false;
}
