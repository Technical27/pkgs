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
  version = "unstable-2022-02-13";

  src = fetchFromGitHub {
    owner = "olive-editor";
    repo = "olive";
    rev = "7d52dc19e3bd5e48a066e95669525cb9387afae4";
    sha256 = "sha256-NL22wszFSh+Lr1Csva4jZyIX4htlIcfh2vnOmX4+zMQ=";
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
    maintainers = [ maintainers.balsoft ];
    platforms = platforms.unix;
  };
}
