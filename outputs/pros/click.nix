{ lib, stdenv, buildPythonPackage, fetchPypi, substituteAll, locale, pytest, fetchpatch }:

buildPythonPackage rec {
  pname = "click";
  version = "6.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
  };

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      locale = "${locale}/bin/locale";
    })
    # Fix tests with newer version of pytest
    (fetchpatch {
      url = "https://github.com/pallets/click/commit/20b4b1c0d1564ab4ef44b7d27d5b650735e28be3.patch";
      sha256 = "sha256-CEcL+0vJK1O/uFt0LBoH8yd5SiGdg7Dldfd49ZGQhkQ=";
    })
  ];

  nativeBuildInputs = [ pytest ];

  checkPhase = ''
    py.test tests
  '';

  pythonImportsCheck = [ "click" ];

  meta = with lib; {
    homepage = http://click.pocoo.org/;
    description = "Create beautiful command line interfaces in Python";
    longDescription = ''
      A Python package for creating beautiful command line interfaces in a
      composable way, with as little code as necessary.
    '';
    license = licenses.bsd3;
  };
}
