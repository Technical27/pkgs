{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "gruvbox-dark-icons-gtk";
  version = "1.0.0";

  src = fetchFromGitHub {
    repo = name;
    owner = "jmattheis";
    rev = "master";
    sha256 = "1fks2rrrb62ybzn8gqan5swcgksrb579vk37bx4xpwkc552dz2z2";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r ${src} $out/share/icons/gruvbox-dark
  '';
}
