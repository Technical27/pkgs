{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, which
, cmake
, mkDerivation
, qtmultimedia
, wrapQtAppsHook
, frei0r
, opencolorio
, openimageio2
, portaudio
, openexr
, ffmpeg-full
, qtbase
, qttools
, qtwayland
, CoreFoundation
}:

mkDerivation rec {
  pname = "olive-editor";
  version = "unstable-2022-06-17";

  src = fetchFromGitHub {
    owner = "olive-editor";
    repo = "olive";
    rev = "5ef56c80473c78c6016f8e698fe6ec25f8d6ecc8";
    sha256 = "sha256-M4zXW2HQ34A8WTyWUdoOAQYl7aLSaQ+3FgPYzKwC6t4=";
  };

  nativeBuildInputs = [
    pkg-config
    which
    cmake
    wrapQtAppsHook
  ];

  buildInputs = [
    ffmpeg-full
    frei0r
    opencolorio
    openimageio2
    portaudio
    openexr
    qtmultimedia
    qtbase
    qttools
    qtwayland
  ] ++ lib.optional stdenv.isDarwin CoreFoundation;

  meta = with lib; {
    description = "Professional open-source NLE video editor";
    homepage = "https://www.olivevideoeditor.org/";
    downloadPage = "https://www.olivevideoeditor.org/download.php";
    license = licenses.gpl3;
    maintainers = [ maintainers.technical27 ];
    platforms = platforms.unix;
  };
}
