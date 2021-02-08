{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "gruvbox-dark-gtk";
  version = "1.0.0";

  src = fetchFromGitHub {
    repo = name;
    owner = "jmattheis";
    rev = "master";
    sha256 = "1j6080bvhk5ajmj7rc8sdllzz81iyafqic185nrqsmlngvjrs83h";
  };

  installPhase = ''
    mkdir -p $out/share/themes
    cp -r ${src} $out/share/themes/gruvbox-dark
  '';

  dontFixup = true;
}
