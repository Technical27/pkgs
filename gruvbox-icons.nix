{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "gruvbox-dark-icons-gtk";
  version = "1.0.0";

  src = fetchFromGitHub {
    repo = name;
    owner = "jmattheis";
    rev = "1eefaa8f543ffc4017fc309798cb80208e4c7c3a";
    sha256 = "sha256-T4KuLcCamupYH2aQmNpAiI+xblyE7p707JHPp/H+3M4=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r ${src} $out/share/icons/gruvbox-dark
  '';
}
