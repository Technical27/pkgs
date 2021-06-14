{ lib, fetchPypi, buildPythonPackage, python3Packages }:

buildPythonPackage rec {
  pname = "PyGObject-stubs";
  version = "0.0.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-+jsljL4+OENVdQY55+KCdsNoBWOasx1GH+pgYqGzuas=";
  };

  propagatedBuildInputs = [ python3Packages.pygobject3 ];

  doCheck = false;
}
