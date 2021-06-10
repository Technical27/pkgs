{ lib, buildPythonPackage, python3Packages, fetchPypi }:

buildPythonPackage rec {
  pname = "scan-build";
  version = "2.0.13";

  patches = [ ./scan-typings.patch ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-kwy1jMwM1GRVNOu0HfI7uXZsl8Smb59cb6n/eEOjkfw=";
  };

  doCheck = false;
}
