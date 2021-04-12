{ lib, stdenv, fetchFromGitHub, cmake, extra-cmake-modules, pkg-config, fcitx5, m17n_lib, m17n_db, gettext, fmt }:

stdenv.mkDerivation rec {
  pname = "fcitx5-m17n";
  version = "5.0.4";

  src = fetchFromGitHub {
    owner = "fcitx";
    repo = pname;
    rev = version;
    sha256 = "sha256-yI6Svr1KEdHqAX3qd7t7GvD0EcWg0A2vZpuJw1U9oKQ=";
  };

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    pkg-config
    gettext
  ];

  buildInputs = [
    fcitx5
    m17n_db
    m17n_lib
    fmt
  ];
}
