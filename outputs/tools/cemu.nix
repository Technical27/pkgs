{ fetchFromGitHub
, lib
, mkDerivation
, SDL2
, libGL
, libarchive
, libusb-compat-0_1
, qtbase
, qmake
, git
, libpng_apng
, pkg-config
}:

mkDerivation rec {
  pname = "CEmu";
  version = "unstable-2021-08-04";
  src = fetchFromGitHub {
    owner = "CE-Programming";
    repo = "CEmu";
    rev = "e96b844b86b2df65e85e8fd5ecae469e1b6b5cc0";
    sha256 = "sha256-9pEHQlCje9LIWm3Tml0YPW+IRfYI5CXv/WR43auXCwE=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    qmake
    git
    pkg-config
  ];

  buildInputs = [
    SDL2
    libGL
    libarchive
    libusb-compat-0_1
    qtbase
    libpng_apng
  ];

  qmakeFlags = [
    "gui/qt"
  ];

  meta = with lib; {
    changelog = "https://github.com/CE-Programming/CEmu/releases/tag/v${version}";
    description = "Third-party TI-84 Plus CE / TI-83 Premium CE emulator, focused on developer features";
    homepage = "https://ce-programming.github.io/CEmu";
    license = licenses.gpl3;
    maintainers = with maintainers; [ luc65r ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
